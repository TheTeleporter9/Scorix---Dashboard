import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> initSupabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  final user = supabase.auth.currentUser;

  // Load environment variables
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  if (user != null) {
    print("fetch data");
  } else {
    print("no useer/ directing to login sreen");
  }

}


Future<void> signUp(String email, String password) async {
  final response = await supabase.auth.signUp(email: email, password: password);
  if (response.user != null) {
    print("User signed up: ${response.user!.id}");
  }
}

Future<void> signIn(String email, String password) async {
  final response = await supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
  if (response.user != null) {
    print("User signed in: ${response.user!.id}");
  }
}
