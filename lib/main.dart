import 'package:flutter/material.dart';
import 'package:dashboard/UI/widgets/TopBar.dart';
import 'package:dashboard/UI/widgets/TabNavBar.dart';
import 'package:dashboard/database/supabase.dart';
import 'package:dashboard/UI/pages/Login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  runApp(MainApp());
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _loggedIn = false;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    try {
      final loggedIn = await isLoggedIn();
      setState(() {
        _loggedIn = loggedIn;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _onLoginSuccess() {
    setState(() {
      _loggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _loading
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : _error != null
              ? Scaffold(
                  body: Center(child: Text('Error: $_error')),
                )
              : _loggedIn
                  ? Scaffold(
                      backgroundColor: Colors.white,
                      body: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: const [
                              TopBar(),
                              Divider(color: Colors.blueGrey, thickness: 2, height: 10),
                              Expanded(child: TabNavigationBar()),
                            ],
                          ),
                        ),
                      ),
                    )
                  : LoginScreen(onLoginSuccess: _onLoginSuccess),
    );
  }
}

