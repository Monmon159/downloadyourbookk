import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class newpage extends StatefulWidget {
  const newpage({super.key});

  @override
  State<newpage> createState() => _newpageState();
}

class _newpageState extends State<newpage> {
  void initState() {
    // TODO: implement initState

    
    super.initState();
    Timer(Duration(seconds: 5),(() {
      Navigator.of(context).pushReplacementNamed('/login');
      
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Image.asset('assets/booka.jpg'),
          Center(child: Text('Welcome !',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 50),)),
        ],
      )
      
    );
  }
 
}