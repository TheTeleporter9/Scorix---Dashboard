import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> signIn() async {
    setState(() => isLoading = true);

    try {
      final response = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final user = response.user;
      if (user != null) {
        print('Signed in: ${user.id}');
        // After login, you can fetch team data
        final team = await getTeam();
        print('Team: $team');

        // Navigate to home screen or main app
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (e) {
      print('Error signing in: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> signUp() async {
    setState(() => isLoading = true);

    try {
      final response = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      final user = response.user;
      if (user != null) {
        print('Signed up: ${user.id}');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign up successful! Check email.')));
      }
    } catch (e) {
      print('Error signing up: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign up failed: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login / Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: signIn,
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: signUp,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

// Example getTeam function
Future<Map<String, dynamic>?> getTeam() async {
  final user = supabase.auth.currentUser;
  if (user == null) return null;

  try {
    final data = await supabase
        .from('teams')
        .select('name, school')
        .eq('user_id', user.id)
        .maybeSingle();

    print('Team data: $data');
    return data as Map<String, dynamic>?;
  } catch (e) {
    print('Error fetching team: $e');
    return null;
  }
}
