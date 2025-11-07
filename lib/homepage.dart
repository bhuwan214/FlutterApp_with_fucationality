import 'package:flutter/material.dart';
import 'searchbar.dart';
import 'gridlayout.dart';


class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){

  //Generating the list of image texts
    return Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:[
          const Text("Welcome to Home Page", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          const SearchBarApp(),
          const SizedBox(height: 20),
           GridWidget()
        ],
      
      ),
    );


  }
}

