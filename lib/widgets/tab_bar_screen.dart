import 'package:flutter/material.dart';
import 'package:nobody/models/list_colors.dart';
import 'package:nobody/screens/sc_financial.dart';
import 'package:nobody/screens/sc_home.dart';
import 'package:nobody/screens/sc_statistices.dart';
import 'package:nobody/widgets/data.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    List screens = [
      StatisticesScreen(),
      FinancialOperationsScreen(),
      HomeScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromARGB(255, 243, 240, 33),
        unselectedItemColor: Colors.white,
        backgroundColor: theDarkMode
            ? darkColors["appBar"]
            : lightColors["primary"],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الاعدادات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'العمليات',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
