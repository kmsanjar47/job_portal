import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/app/views/job_history.dart';
import 'package:job_portal/app/views/profile_view.dart';
import 'package:job_portal/app/views/saved_view.dart';
import 'package:job_portal/app/views/search_view.dart';
import 'home_view.dart';

class NavigationViewPublisher extends StatefulWidget {
  const NavigationViewPublisher({super.key});

  @override
  State<NavigationViewPublisher> createState() => _NavigationViewPublisherState();
}

class _NavigationViewPublisherState extends State<NavigationViewPublisher> {
  int currentNavbarIdx = 0;
  List pages = [
    HomeView(),
    const SearchView(),
    const SavedView(),
    const JobHistory(),
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
                Icons.bookmark,
                color: currentNavbarIdx == 2
                    ? const Color(0xFF43D3FF)
                    : const Color(0xFF494949),
              ),
              label: "Saved Jobs"),
          BottomNavigationBarItem(
            label: "Job History",
            icon: Icon(Icons.history_rounded,
                color: currentNavbarIdx == 3
                    ? const Color(0xFF43D3FF)
                    : const Color(0xFF494949)),
          ),


          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled,
                  color: currentNavbarIdx == 4
                      ? const Color(0xFF43D3FF)
                      : const Color(0xFF494949)),
              label: "Profile"),
        ],
      ),
      body: pages[currentNavbarIdx],
    );
  }
}
