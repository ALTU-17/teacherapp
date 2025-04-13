import 'package:flutter/material.dart';
import 'package:teacherapp/views/dashBoard/calendar_Page.dart';
import 'package:teacherapp/views/dashBoard/dashboard_page.dart';
import 'package:teacherapp/views/dashBoard/drawer_Page.dart';
import 'package:teacherapp/views/dashBoard/teacherProfile.dart';


class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [
    DashboardPage(),  // Dashboard Page (Existing UI)
    CalendarScreen(), // New Calendar Page
    TeacherProfilePage(),  // New Profile Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 9, 75),
        elevation: 0,
        title: const Text(
          'SACS Smart Teacher App (2024-2025)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: Icon(Icons.menu, color: Colors.pink),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DrawerPage();
              },
            );
          },
        ),
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 211, 85, 76),
        backgroundColor: const Color.fromARGB(255, 95, 156, 206),
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
