import 'package:flutter/material.dart';

class MovieAdmin extends StatefulWidget {
  const MovieAdmin({super.key});
  static const routeName = '/genre_admin';

  @override
  State<MovieAdmin> createState() => _MovieAdminState();
}

class _MovieAdminState extends State<MovieAdmin> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Selamat datang user'),
    );
  }
}
