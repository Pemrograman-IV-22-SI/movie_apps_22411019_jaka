import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:movie_apps/users/beli_movie.dart';
import 'package:movie_apps/users/transaksi.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toastification/toastification.dart';

class HomeUsers extends StatefulWidget {
  const HomeUsers({super.key});
  static const routeName = '/home-users';

  @override
  State<HomeUsers> createState() => _HomeUsersState();
}

class _HomeUsersState extends State<HomeUsers> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final dio = Dio();
  bool isLoading = false;
  var dataMovie = [];
  var user = {};
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 255, 171, 36),
            title: Row(
              children: [
                Text("Movie", style: TextStyle(color: Colors.white)),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Transaksi.routeName);
                },
                icon: const Icon(Icons.shopping_basket),
                color: Colors.white,
              )
            ]),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: dataMovie.length,
                itemBuilder: (context, index) {
                  final movie = dataMovie[index];
                  return Card(
                    color: Colors.grey[850],
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar Film
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              imageUrl + movie['image'],
                              width: 80,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 120,
                                  color: Colors.grey,
                                  child:
                                      const Icon(Icons.broken_image, size: 40),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Detail Film
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Judul Film
                                Text(
                                  movie['tittle'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // Genre
                                Text(
                                  "Genre: ${movie['tb_genre']['genre']}",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // Rating dengan Bintang
                                Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      Icons.star,
                                      size: 16,
                                      color: starIndex < movie['rating'].toInt()
                                          ? Colors.yellow
                                          : Colors.grey,
                                    ),
                                  )..add(
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          movie['rating'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                ),
                                const SizedBox(height: 10),
                                Text("Rp. ${movie['price']}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                const SizedBox(height: 10),
                                // Deskripsi Film
                                Text(
                                  movie['description'],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Order',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, BeliMovie.routeName,
                                            arguments: {
                                              "movie": movie,
                                              "user": args
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }

  void getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      Response response;
      response = await dio.get(getAllMovie);
      if (response.data['status'] == true) {
        dataMovie = response.data['data'];
        print(dataMovie);
      } else {
        dataMovie = [];
      }
    } catch (e) {
      toastification.show(
          context: context,
          title: Text('Server tidak merespon'),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
          style: ToastificationStyle.fillColored);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
