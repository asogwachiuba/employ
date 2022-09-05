import 'package:employ/constants/custom_colors.dart';
import 'package:employ/screens/employee/home_page/employee_home_tab.dart';
import 'package:employ/screens/employee/home_page/submitted_jobs.dart';
import 'package:employ/screens/employee/home_page/profile_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final tab = [
    const EmployeeHomeTab(),
   // const ViewedJobs(),
    const ProfileInfo()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: SingleChildScrollView(
        child:tab[_currentIndex] ,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: CColor.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: CColor.white,
              label: 'JOBS',
              icon: Icon(Icons.home_filled,size: 25,)),
          // BottomNavigationBarItem(
          //     backgroundColor: CColor.white,
          //     label: 'Posted Jobs',
          //     icon: Icon(Icons.menu_book,size: 25,)),
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
