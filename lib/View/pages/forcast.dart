import 'package:flutter/material.dart';

class ForcastPage extends StatefulWidget {
  const ForcastPage({super.key});

  @override
  State<ForcastPage> createState() => _ForcastPageState();
}

class _ForcastPageState extends State<ForcastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Forcast Page')),
      ),
    );
  }
}
