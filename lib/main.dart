import 'package:flutter/material.dart';
import 'package:gifs_app/pages/home.dart';

void main (){
  runApp(
    MaterialApp(
      home: HomePage(),
      theme: ThemeData(hintColor: Colors.black, primaryColor: Colors.black, accentColor: Colors.black),
    )
  );
}