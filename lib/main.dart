import 'package:flutter/material.dart';
import 'package:scan_ycv_app/crop.dart';
import 'package:scan_ycv_app/history.dart';
import 'package:scan_ycv_app/home.dart';
import 'package:scan_ycv_app/scan_photo.dart';
import 'package:scan_ycv_app/splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => Splash(),
      "/home": (context) => Home(),
      "/scan": (context) => Scan(),
      "/crop": (context) => MyApp(),
      "/history": (context) => HistoryScreen(),
    },
  ));
}
