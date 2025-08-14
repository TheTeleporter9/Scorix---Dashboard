import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Matchitem extends StatelessWidget {
  final String matchNumber;
  final String team1Name;
  final String team2Name;
  final String tableNumber;

  const Matchitem({
    super.key,
    required this.matchNumber,
    required this.tableNumber,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            //Matchnumber
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(matchNumber),
            ),
            const SizedBox(
              width: 12,
            ),

            //Teams
            Expanded(
              child: Center(
                child: Text(
              "$team1Name vs $team2Name",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ))),
            Chip(
              label: Text(tableNumber),
              backgroundColor: Colors.blue[100],
            ),
          ],
        ),
      ),
    );
  }
}
