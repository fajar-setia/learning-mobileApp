import 'package:flutter/material.dart';
import 'package:flutter_app/pages/product_page.dart';
import '../pages/home_page.dart';

class FloatingBottomNav extends StatefulWidget {
  const FloatingBottomNav({super.key});

  @override
  FloatingBottomNavState createState() => FloatingBottomNavState();
}

class FloatingBottomNavState extends State<FloatingBottomNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProductPage(),
    Center(child: Text('Profile Page')), // placeholder
    Center(child: Text('Settings Page')), // placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home, Icons.home_outlined, 'Home'),
              _buildNavItem(1, Icons.add_chart, Icons.add_chart_outlined, 'Product'),
              _buildNavItem(2, Icons.person, Icons.person_outline, 'Profile'),
              _buildNavItem(3, Icons.settings, Icons.settings_outlined, 'Settings'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
  ) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.deepPurple.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? Colors.deepPurple : Colors.grey[600],
              size: 24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? Colors.deepPurple : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void changeTabByRoute(String route) {
    setState(() {
      switch (route) {
        case '/product':
          _currentIndex = 1;
          break;
        case '/profile':
          _currentIndex = 2;
          break;
        case '/settings':
          _currentIndex = 3;
          break;
        default:
          _currentIndex = 0;
      }
    });
  }
}
