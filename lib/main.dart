import 'package:flutter/material.dart';
import 'package:projeto/pages/my_app.dart';

void main() {
  try {
    return runApp(const MyApp());
  } catch (e) {
    return runApp(Text("Error to build app: $e"));
  }
}
