import 'dart:developer';

import 'package:complex_api_flutter/ProductExample.dart';
import 'package:complex_api_flutter/login.dart';
import 'package:complex_api_flutter/signupApi.dart';
import 'package:complex_api_flutter/uploadImage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complex Api',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: UploadImage(),
    );
  }
}



