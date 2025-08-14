import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  const LoginScreen({super.key, this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // Safe getter for the Supabase client
  SupabaseClient get supabase => Supabase.instance.client;

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
        final team = await getTeam();
        print('Team: $team');

        // Call callback if provided
        if (widget.onLoginSuccess != null) {
          widget.onLoginSuccess!();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed: Invalid credentials')));
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
      return data;
    } catch (e) {
      print('Error fetching team: $e');
      return null;
    }
  }

}
