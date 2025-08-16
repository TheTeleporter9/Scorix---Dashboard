import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';


final supabase = Supabase.instance.client;

/// A widget that shows the current user's avatar and allows uploading a new one.
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

  Future<void> loadAvatar() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      // Try to fetch the public avatar URL from storage
      final path = 'avatars/${user.id}.png';
      final url = _supabase.storage.from('avatars').getPublicUrl(path).data;
      setState(() {
        avatarUrl = url;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading avatar: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> uploadAvatar() async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    withData: true, // important for Web
  );

  if (result == null || result.files.isEmpty) return;

  final bytes = result.files.first.bytes!;
  final path = 'avatars/${user.id}.png';

  try {
    await supabase.storage.from('avatars').upload(
      path,
      bytes as File,
      fileOptions: const FileOptions(upsert: true),
    );
    final url = supabase.storage.from('avatars').getPublicUrl(path).data;
    setState(() {
      avatarUrl = url;
    });
  } catch (e) {
    print('Error uploading avatar: $e');
  }
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
      onTap: uploadAvatar, // Tap to upload a new avatar
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null ? const Icon(Icons.person, size: 30) : null,
      ),
    );
  }
}

extension on String {
   get data => null;
}
