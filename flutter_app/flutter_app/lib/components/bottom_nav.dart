import 'package:flutter/material.dart';
import 'package:flutter_app/pages/product_page.dart';
import '../pages/home_page.dart';

// Alternatif: Floating Bottom Navigation dengan Notch
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
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF667EEA).withValues(alpha: 0.3),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Action untuk FAB
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home, Icons.home_outlined, 'Home'),
              _buildNavItem(1, Icons.search, Icons.pie_chart_outline, 'Product'),
              SizedBox(width: 40), // Space for FAB
              _buildNavItem(2, Icons.person, Icons.person_outline, 'Profile'),
              _buildNavItem(3, Icons.settings, Icons.settings_outlined, 'Settings'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
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
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive 
                ? Color(0xFF667EEA).withValues(alpha: 0.1) 
                : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? Color(0xFF667EEA) : Colors.grey[600],
              size: 24,
            ),
          ),
          SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? Color(0xFF667EEA) : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}