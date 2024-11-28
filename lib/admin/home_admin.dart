import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_apps/admin/genre/genre.dart';
import 'package:movie_apps/admin/movie/movie_admin.dart';
import 'package:movie_apps/admin/transaksi_admin.dart';
import 'package:movie_apps/auth/login_page.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});
  static const routeName = '/home_admin';

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Movie Apps',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(221, 255, 255, 255)),
          )
        ]),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 171, 36),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Genre.routeName),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/genre.png',
                      width: 100,
                    ),
                    const Text('Menu Genre')
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, MovieAdmin.routeName),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/movie.png',
                      width: 100,
                    ),
                    const Text('Menu Movie')
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
              ),
            ]),
            const SizedBox(
              height: 50,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, TransaksiAdmin.routeName),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/transaksi.png',
                      width: 100,
                    ),
                    const Text('Menu Transaksi')
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, LoginPage.routeName),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logout.png',
                      width: 100,
                    ),
                    const Text('Keluar')
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
