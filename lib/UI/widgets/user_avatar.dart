import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'dart:convert';

final supabase = Supabase.instance.client;

/// Widget that displays the current user's avatar (Supabase Storage or Gravatar)
/// and allows uploading a new one.
class UserAvatar extends StatefulWidget {
  final double radius;

  const UserAvatar({super.key, this.radius = 30});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  String? avatarUrl;
  bool isLoading = true;

  SupabaseClient get _supabase => Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    loadAvatar();
  }

  /// Load avatar from Supabase Storage; fallback to Gravatar
  Future<void> loadAvatar() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      // Try Supabase Storage
      final path = 'avatars/${user.id}.png';
      final url = _supabase.storage.from('avatars').getPublicUrl(path).data;

      setState(() {
        avatarUrl = url ?? gravatarUrl(user.email);
        isLoading = false;
      });
    } catch (e) {
      print('Error loading avatar: $e');
      // fallback to Gravatar
      setState(() {
        avatarUrl = gravatarUrl(user.email);
        isLoading = false;
      });
    }
  }

  /// Upload a new avatar to Supabase Storage
  Future<void> uploadAvatar() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // Important for Web
    );

    if (result == null || result.files.isEmpty) return;

    final Uint8List bytes = result.files.first.bytes!;
    final path = 'avatars/${user.id}.png';

    try {
      await _supabase.storage
          .from('avatars')
          .upload(path, bytes as File, fileOptions: const FileOptions(upsert: true));

      final url = _supabase.storage.from('avatars').getPublicUrl(path).data;
      setState(() {
        avatarUrl = url;
      });
    } catch (e) {
      print('Error uploading avatar: $e');
    }
  }

  /// Generate Gravatar URL from email
  String gravatarUrl(String? email) {
    if (email == null) return '';
    final normalized = email.trim().toLowerCase();
    final hash = md5.convert(utf8.encode(normalized));
    return "https://www.gravatar.com/avatar/$hash?s=200&d=identicon";
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircleAvatar(
        radius: widget.radius,
        child: const CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: uploadAvatar,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
            ? NetworkImage(avatarUrl!)
            : null,
        child: avatarUrl == null || avatarUrl!.isEmpty
            ? const Icon(Icons.person, size: 30)
            : null,
      ),
    );
  }
}

extension on String {
   Null get data => null;
}
