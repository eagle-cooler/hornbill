import 'package:flutter/material.dart';
import 'screens/file_manager_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hornbill - Eagle File Manager',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const FileManagerScreen(),
    );
  }
}
