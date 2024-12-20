import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/app/views/profile_view.dart';
import 'package:job_portal/app/views/search_view.dart';
import 'home_view.dart';
import 'notification_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int currentNavbarIdx = 0;
  List pages = [
    const HomeView(),
    const SearchView(),
    const NotificationView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF43D3FF),
        unselectedItemColor: const Color(0xFF494949),
        type: BottomNavigationBarType.shifting,
        currentIndex: currentNavbarIdx,
        onTap: (value) {
          setState(() {
            currentNavbarIdx = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentNavbarIdx == 0
                    ? const Color(0xFF43D3FF)
                    : const Color(0xFF494949),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: currentNavbarIdx == 1
                    ? const Color(0xFF43D3FF)
                    : const Color(0xFF494949),
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_active_outlined,
                color: currentNavbarIdx == 2
                    ? const Color(0xFF43D3FF)
                    : const Color(0xFF494949),
              ),
              label: "Notification"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled,
                  color: currentNavbarIdx == 3
                      ? const Color(0xFF43D3FF)
                      : const Color(0xFF494949)),
              label: "Profile"),
        ],
      ),
      body: pages[currentNavbarIdx],
    );
  }
}
