import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

/// Initialize Supabase with dotenv variables
Future<void> initSupabase() async {
  // Load environment variables
  await dotenv.load(fileName: "env.dev");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
}

/// Sign up a new user
Future<void> signUp(String email, String password) async {
  final response = await supabase.auth.signUp(
    email: email,
    password: password,
  );
  if (response.user != null) {
    print("User signed up: ${response.user!.id}");
  }
}

/// Sign in an existing user
Future<void> signIn(String email, String password) async {
  final response = await supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
  if (response.user != null) {
    print("User signed in: ${response.user!.id}");
  }
}

/// Check if a user is logged in
Future<bool> isLoggedIn() async {
  final user = supabase.auth.currentUser;
  return user != null;
}
