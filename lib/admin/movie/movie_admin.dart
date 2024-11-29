import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/admin/home_admin.dart';
import 'package:movie_apps/admin/movie/input_movie.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toastification/toastification.dart';

class MovieAdmin extends StatefulWidget {
  const MovieAdmin({super.key});
  static const routeName = '/movie-admin';

  @override
  State<MovieAdmin> createState() => _MovieAdminState();
}

class _MovieAdminState extends State<MovieAdmin> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final dio = Dio();
  bool isLoading = false;
  var dataMovie = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 255, 171, 36),
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeAdmin.routeName);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text("Movie", style: TextStyle(color: Colors.white)),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, InputMovie.routeName);
                },
                icon: const Icon(Icons.add),
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
                                      'Edit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.confirm,
                                            title: 'Hapus Movie',
                                            text:
                                                'Data Movie akan Dihapus anda yakin ${movie['tittle']}?',
                                            confirmBtnText: 'ya',
                                            cancelBtnText: 'No',
                                            confirmBtnColor: Colors.redAccent,
                                            onConfirmBtnTap: () {
                                              deleteMovieResponse(
                                                  movie['id_movie']);
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
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

  void deleteMovieResponse(int id) async {
    try {
      setState(() {
        isLoading = true;
      });
      Response response;
      response = await dio.delete(hapusMovie + id.toString());
      if (response.data['status'] == true) {
        toastification.show(
          context: context,
          title: Text(response.data['msg']),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          autoCloseDuration: const Duration(seconds: 2),
        );
        Navigator.pushNamed(context, MovieAdmin.routeName);
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
    ;
  }
}
