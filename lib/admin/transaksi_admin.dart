import 'package:flutter/material.dart';

class TransaksiAdmin extends StatefulWidget {
  const TransaksiAdmin({super.key});
  static const routeName = '/genre_admin';

  @override
  State<TransaksiAdmin> createState() => _TransaksiAdminState();
}

class _TransaksiAdminState extends State<TransaksiAdmin> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Selamat datang user'),
    );
  }
}
