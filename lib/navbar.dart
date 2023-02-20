import 'package:brilloconnetz/colors.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final int? currentIndex;
  final void Function(int)? onTap;

  const CustomNavBar({Key? key, this.currentIndex = 0, this.onTap})
      : super(key: key);

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.makeColor('F9FAFB'),
      type: BottomNavigationBarType.fixed,
      onTap: widget.onTap,
      selectedItemColor: AppColors.makeColor('035397'),
      selectedLabelStyle: TextStyle(
        color: AppColors.makeColor('035397'),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      selectedFontSize: 20.0,
      selectedIconTheme:
          IconThemeData(color: AppColors.makeColor('035397'), size: 21),
      unselectedItemColor: AppColors.makeColor('626262'),
      unselectedLabelStyle: TextStyle(
        color: AppColors.makeColor('035397'),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedFontSize: 20.0,
      unselectedIconTheme:
          IconThemeData(color: AppColors.makeColor('626262'), size: 21),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      elevation: 0,
      currentIndex: widget.currentIndex!,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Buddies',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
