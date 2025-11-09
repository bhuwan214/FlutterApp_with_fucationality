import 'package:flutter/material.dart';
import 'profilecard.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Card App",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        cardTheme: const CardThemeData(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        cardTheme: const CardThemeData(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: _themeMode,
      home: ProfileScreen(isDark: _themeMode == ThemeMode.dark, onThemeToggle: _toggleTheme),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeToggle;
  final bool isDark;
  
  const ProfileScreen({super.key, required this.onThemeToggle, required this.isDark});
  
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    //Page options for body

    final pages = [
      HomePage(isDark: widget.isDark, onThemeToggle: widget.onThemeToggle),
      const Center(child: ProfileCard()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedIndex == 0?'Home Page':'Profile Card Example'),
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 5,
        child: ListView(
          // padding:EdgeInsets.all(4),
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Text(
                  'Navigation Menu',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected:selectedIndex==0,
              onTap: () {
                    setState(() {
                  selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected:selectedIndex==1,
              
              onTap: () {
                  setState(() {
                  selectedIndex = 1;
                });
                Navigator.pop(context);
                
              },
            ),
          ],
        ),
      ),
      body:pages[selectedIndex],
    );
  }
}
