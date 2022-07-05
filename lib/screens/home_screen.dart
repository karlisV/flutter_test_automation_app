import 'package:flutter/material.dart';
import 'package:test_automation/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      body: Center(
        child: Text('TODO'),
      ),
    );
  }
}
