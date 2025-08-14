import 'package:dashboard/UI/pages/Matchoverview/matchItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Matchoverview extends StatefulWidget{

  const Matchoverview({super.key});

  @override
  State<Matchoverview> createState() => _MatchoverviewState();


}

class _MatchoverviewState extends State<Matchoverview> {

  final List matches = [
    "1",
    "2",
    "3",
    "4"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index){
          return Matchitem(
            matchNumber: matches[index], 
            tableNumber: "1",
            team1Name: "Bob the builders",
            team2Name: "Generic Team 2");
       },
      ) 
    );
  }

}

