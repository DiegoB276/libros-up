import 'package:flutter/material.dart';
import 'package:librosup/screens/home_screen.dart';
import 'package:librosup/screens/recomended_books_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final pages = const [HomeScreen(), RecomendedBooksScreen()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey.shade600,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            label: "Inicio",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Recomendados",
            icon: Icon(Icons.book),
          ),
        ],
      ),
    );
  }
}
