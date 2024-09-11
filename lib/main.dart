import 'package:flutter/material.dart';
import 'screens/chat_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp UI Clone',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ChatListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
