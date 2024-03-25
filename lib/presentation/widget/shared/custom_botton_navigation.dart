import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottonNavigation extends StatelessWidget {
  final int index;
  final double iconSized;

  const BottonNavigation({
    super.key,
    required this.index,
    required this.iconSized,
  });

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value)=>onItemTapped(context,value),
      currentIndex: index, items: [
      BottomNavigationBarItem(
        label: 'Character',
        icon: Icon(
          Icons.person,
          size: iconSized,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Episode',
        icon: Icon(
          Icons.tv_outlined,
          size: iconSized,
        ),
      ),
      BottomNavigationBarItem(
        label: 'Location',
        icon: Icon(
          Icons.location_on_outlined,
          size: iconSized,
        ),
      ),
    ]);
  }
}
