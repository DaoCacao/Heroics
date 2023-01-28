import 'package:flutter/material.dart';
import 'package:heroics/presentation/screen/main/main_bloc.dart';

/// Main screen.
class MainScreen extends StatelessWidget {
  final MainPage page;
  final Function() onSettingsClick;
  final Function(MainPage) onPageChange;

  const MainScreen({
    super.key,
    required this.page,
    required this.onSettingsClick,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: page.when(
          home: () => const Text("Home"),
          profile: () => const Text("Profile"),
          library: () => const Text("Library"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: onSettingsClick,
          ),
        ],
      ),
      body: page.when(
        home: () => Container(
          color: Colors.red,
        ),
        profile: () => Container(
          color: Colors.green,
        ),
        library: () => Container(
          color: Colors.blue,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page.index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "Library",
          ),
        ],
        onTap: (index) => onPageChange(index.page),
      ),
    );
  }
}

extension _MainPageX on MainPage {
  int get index => when(
        home: () => 0,
        profile: () => 1,
        library: () => 2,
      );
}

extension _IntX on int {
  MainPage get page {
    switch (this) {
      case 0:
        return const MainPage.home();
      case 1:
        return const MainPage.profile();
      case 2:
        return const MainPage.library();
      default:
        throw Exception("Invalid index");
    }
  }
}
