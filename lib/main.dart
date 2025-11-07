import 'package:flutter/material.dart';
import 'profilecard.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Profile Card Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    //Page options for body

    final pages = [
      const HomePage(),
      const Center(child: ProfileCard()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedIndex == 0?'Home Page':'Profile Card Example'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 5,
        child: ListView(
          // padding:EdgeInsets.all(4),
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text(
                  'Navigation Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
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
