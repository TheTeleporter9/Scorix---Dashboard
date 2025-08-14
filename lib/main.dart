import 'package:flutter/material.dart';
import 'package:dashboard/UI/TopBar.dart';
import 'package:dashboard/UI/TabNavBar.dart';
import 'package:dashboard/database/supabase.dart';
import 'package:dashboard/UI/pages/Login/login_screen.dart';

void main() {

  initSupabase();

  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isLoggedIn(), // Check login status with Supabase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData && snapshot.data == true) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TopBar(),
                      Divider(color: Colors.blueGrey, thickness: 2, height: 10),
                      Expanded(child: TabNavigationBar()),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const LoginScreen(); // <-- Use your LoginScreen here
          }
        },
      ),
    );
  }
}

