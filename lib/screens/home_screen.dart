import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uas_app/screens/add_screen.dart';
import 'package:uas_app/screens/dashboard_screen.dart';
import 'package:uas_app/screens/explore_screen.dart';
import 'package:uas_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> pages = [
    DashboardScreen(),
    ExploreScreen(),
    AddScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.white,
            color: Colors.black54,
            tabBackgroundColor: Color.fromARGB(220, 20, 10, 128),
            padding: EdgeInsets.all(16),
            activeColor: Colors.white,
            tabs: const [
              GButton(
                icon: FluentIcons.grid_20_filled,
                text: "Dashboard",
              ),
              GButton(
                icon: FluentIcons.compass_northwest_20_filled,
                text: "Explore",
              ),
              GButton(
                icon: FluentIcons.add_20_filled,
                text: "Add data",
              ),
              GButton(
                icon: FluentIcons.person_20_filled,
                text: "Profile",
              ),
            ],
            selectedIndex: selectedIndex, // Set the current active index
            onTabChange: (index) {
              // Handle tab change, update the state if necessary
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
