import 'package:flutter/material.dart';
import 'package:movie_apps/admin/genre/genre.dart';
import 'package:movie_apps/admin/home_admin.dart';
import 'package:movie_apps/admin/movie_admin.dart';
import 'package:movie_apps/admin/transaksi_admin.dart';
import 'package:movie_apps/auth/login_page.dart';
import 'package:movie_apps/auth/register_page.dart';
import 'package:movie_apps/users/home_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Apps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        HomeAdmin.routeName: (context) => const HomeAdmin(),
        HomeUsers.routeName: (context) => const HomeUsers(),
        Genre.routeName: (context) => const Genre(),
        TransaksiAdmin.routeName: (context) => const TransaksiAdmin(),
        MovieAdmin.routeName: (context) => const MovieAdmin()
      },
    );
  }
}
