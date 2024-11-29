import 'package:flutter/material.dart';

class HomeUsers extends StatefulWidget {
  const HomeUsers({super.key});
  static const routeName = '/home-users';

  @override
  State<HomeUsers> createState() => _HomeUsersState();
}

class _HomeUsersState extends State<HomeUsers> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Selamat datang user'),
    );
  }
}
