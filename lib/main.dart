import 'package:flutter/material.dart';
import 'package:dashboard/UI/TopBar.dart';
import 'package:dashboard/UI/TabNavBar.dart';
import 'package:dashboard/database/supabase.dart';

void main() {

  initSupabase();

  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

 @override
  Widget build(BuildContext context) {
   return const MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Scaffold(
       backgroundColor: Colors.white,
       body:SafeArea(
         child: Padding(
           padding: EdgeInsets.all(16.0),
           child: Column(
             children: [
               TopBar(),
               Divider(color: Colors.blueGrey , thickness: 2, height: 10),
               Expanded(child: TabNavigationBar()),
             ],
           ),
         ),
       ),
     ),
   );
  }
}
