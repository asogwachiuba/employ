import 'package:employ/constants/custom_colors.dart';
import 'package:employ/screens/employer/employer_home_page/employer_home_tab.dart';
import 'package:employ/screens/employer/employer_home_page/posted_jobs.dart';
import 'package:employ/screens/employer/employer_profile_info/employer_profile_info.dart';
import 'package:flutter/material.dart';

class EmployerHomePage extends StatefulWidget {
  const EmployerHomePage({Key? key}) : super(key: key);

  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {
  int _currentIndex = 0;

  final tab = [
    const EmployerHomeTab(),
    const PostedJobs(),
    const EmployerProfileInfo()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: tab[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: CColor.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: CColor.white,
              label: 'Home',
              icon: Icon(Icons.home_filled,size: 25,)),
          BottomNavigationBarItem(
            backgroundColor: CColor.white,
              label: 'Posted Jobs',
              icon: Icon(Icons.menu_book,size: 25,)),
          BottomNavigationBarItem(
            backgroundColor: CColor.white,
              label: 'Profile',
              icon: Icon(Icons.person_outline_rounded,size: 25,)),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
