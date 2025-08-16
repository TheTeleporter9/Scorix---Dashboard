import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Variables for configurable U
    const String eventStatus = 'Active';
    const Color eventStatusColor = Colors.orangeAccent;
    const String eventTitle = 'WRO Robosports Championship 2025';
    const String onlineStatus = '4/4 Online';
    final Color onlineStatusBg = Colors.grey.shade200;
    const String eventVenue = 'Singapore Expo';
    const String eventVenueDetail = 'Convention Center';
    const String eventDate = 'Aug 3, 2025';
    const int eventTemperature = 26;
    const String eventWeather = 'Partly Cloudy';
    const String eventRound = '🏆 Round 1 of 3';
    final Color eventRoundBg = Colors.blue.shade100;
    const String teamsCount = '48 Teams';
    // System statuses
    const String wifiStatus = 'good';
    const Color wifiColor = Colors.redAccent;
    const String storageStatus = 'online';
    const Color storageColor = Colors.green;
    const String videoStatus = 'partial';
    const Color videoColor = Colors.orange;
    const String powerStatus = 'normal';
    const Color powerColor = Colors.green;
    // Progress
    const double progress = 0.75;
    final String progressText = '${(progress * 100).toStringAsFixed(0)}% Complete';
    const String startedTime = 'Started 09:00 AM';
    const String matchesStatus = '96 of 144 matches';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Top row: Event title and status
      Row(
        children: [
        Icon(Icons.circle, size: 8, color: eventStatusColor),
        const SizedBox(width: 4),
        Text(
          eventStatus,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
          eventTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
          color: onlineStatusBg,
          borderRadius: BorderRadius.circular(10),
          ),
          child: Text(onlineStatus, style: const TextStyle(fontSize: 12)),
        ),
        ],
      ),
      const SizedBox(height: 6),

      // Event details row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Expanded(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(eventVenue, style: const TextStyle(fontSize: 12)),
            Text(eventVenueDetail, style: const TextStyle(fontSize: 12)),
          ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(eventDate, style: const TextStyle(fontSize: 12)),
          Row(
            children: [
            const Icon(Icons.thermostat, size: 14),
            const SizedBox(width: 4),
            Text('$eventTemperature°C', style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 6),
            Text(eventWeather, style: const TextStyle(fontSize: 12)),
            ],
          ),
          ],
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
          color: eventRoundBg,
          borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
          eventRound,
          style: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
          const Icon(Icons.group, size: 14),
          const SizedBox(width: 4),
          Text(teamsCount, style: const TextStyle(fontSize: 12)),
          ],
        ),
        ],
      ),
      const SizedBox(height: 6),

      // System statuses row
      Row(
        children: [
        Icon(Icons.wifi, color: wifiColor, size: 14),
        const SizedBox(width: 4),
        Text(wifiStatus, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 8),
        Icon(Icons.storage, color: storageColor, size: 14),
        const SizedBox(width: 4),
        Text(storageStatus, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 8),
        Icon(Icons.videocam, color: videoColor, size: 14),
        const SizedBox(width: 4),
        Text(videoStatus, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 8),
        Icon(Icons.bolt, color: powerColor, size: 14),
        const SizedBox(width: 4),
        Text(powerStatus, style: const TextStyle(fontSize: 12)),
        ],
      ),
      const SizedBox(height: 8),

      // Progress bar
      const Text('Event Progress', style: TextStyle(fontSize: 12)),
      const SizedBox(height: 4),
      Stack(
        children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
          ),
        ),
        FractionallySizedBox(
          widthFactor: progress, // progress variable
          child: Container(
          height: 6,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
            colors: [Colors.orange, Colors.blue],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          ),
        ),
        ],
      ),
      const SizedBox(height: 4),

      // Bottom details
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(progressText, style: const TextStyle(fontSize: 12)),
        Row(
          children: [
          const Icon(Icons.access_time, size: 14),
          const SizedBox(width: 4),
          Text(startedTime, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 10),
          const Icon(Icons.emoji_events, size: 14),
          const SizedBox(width: 4),
          Text(matchesStatus, style: const TextStyle(fontSize: 12)),
          ],
        ),
        ],
      ),
      ],
    );
  }
}
