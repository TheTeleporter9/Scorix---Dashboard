import 'package:dashboard/UI/pages/Matchoverview/MatchOverview.dart';
import 'package:flutter/material.dart';

class TabNavigationBar extends StatefulWidget {
  const TabNavigationBar({super.key});

  @override
  State<TabNavigationBar> createState() => _TabNavigationBarState();
}


class _TabNavigationBarState extends State<TabNavigationBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    Center(child: Matchoverview() ),
    Center(child: Text('Teams')),
    Center(child: Text('Live Monitor Page')),
    Center(child: Text('Analytics Page')), 
    Center(child: Text('Settings Page')),
  ];

  final List<_NavItem> items = const [
    _NavItem(icon: Icons.description, label: 'Match Overview'),
    _NavItem(icon: Icons.group, label: 'Teams'),
    _NavItem(icon: Icons.desktop_windows, label: 'Live Monitor'),
    _NavItem(icon: Icons.bar_chart, label: 'Analytics'),
    _NavItem(icon: Icons.settings, label: 'Settings'),
  ];

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () => onTabTapped(index),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade100 : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(item.icon,
                            size: 18,
                            color: isSelected ? Colors.blue : Colors.black),
                        const SizedBox(width: 6),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),

          // Active page content
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
