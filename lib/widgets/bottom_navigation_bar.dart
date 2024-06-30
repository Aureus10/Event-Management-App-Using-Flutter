import 'package:assignment/theme/colors.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;

  void _onSelected(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, size: 28,),
            label: 'Event Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 28,),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomizedColors.selectedColor,
        unselectedItemColor: CustomizedColors.disabledColor,
        onTap: _onSelected,
        //iconSize: 480,
        );
  }
}

// class BottomMenu extends BottomNavigationBar {

//   int _selectedIndex = 0;

//   void _onSelected(int index) {
//     setState() => _selectedIndex = index;
//   }

//   BottomMenu({super.key})
//       : super(items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//         ], currentIndex: _selectedIndex,
//         selectedItemColor: const Color(0x00444cb4),
//         onTap: _onSelected);
// }
