import 'package:flutter/material.dart';
import 'searchbar.dart';
import 'gridlayout.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<bool> onThemeToggle;
  final bool isDark;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";

  void _handleSearch(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.isDark;

    //Generating the list of image texts
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Welcome to Home Page",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          SearchBarApp(
            isDark: isDark,
            onThemeToggle: widget.onThemeToggle,
            onSearch: _handleSearch,
          ),
          const SizedBox(height: 20),
          GridWidget(searchQuery: searchQuery),
        ],
      ),
    );
  }
}
