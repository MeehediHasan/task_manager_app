import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/update_profile_screen.dart';

import '../controller/auth_controller.dart';
import '../utility/app_colors.dart';
import '../widgets/network_cached_image.dart';
import 'auth_screen/sign_in_screen.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'in_progress_task_screen.dart';
import 'new_task_screen.dart';

class MainButtonNavScreen extends StatefulWidget {
  const MainButtonNavScreen({super.key});

  @override
  State<MainButtonNavScreen> createState() => _MainButtonNavScreenState();
}

class _MainButtonNavScreenState extends State<MainButtonNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const InProgressTaskScreen(),
    const CancelledTaskScreen()
  ];

  @override
  Widget build(BuildContext context, [fromUpdateProfile = false]) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProfileScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: NetworkCachedImage(
                url: "",
              ),
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            if (fromUpdateProfile) {
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProfileScreen(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userData?.fullName ?? "",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                AuthController.userData?.email ?? "",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthController.clearData();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // Added currentIndex to sync with the selected item
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'New Task'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancelled'),
        ],
      ),
    );
  }
}
