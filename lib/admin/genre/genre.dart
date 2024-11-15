import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_apps/admin/genre/input_genre.dart';
import 'package:movie_apps/admin/genre/update_genre.dart';
import 'package:movie_apps/admin/home_admin.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toastification/toastification.dart';

class Genre extends StatefulWidget {
  const Genre({super.key});
  static const routeName = '/genre';

  @override
  State<Genre> createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  final dio = Dio();
  bool isloading = false;
  var dataGenre = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeAdmin.routeName);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            Text("Genre", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, InputGenre.routeName);
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 171, 36),
      ),
      backgroundColor: Colors.white,
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                var genre = dataGenre[index];
                return ListTile(
                    title: Text(
                      genre['genre'],
                      style: const TextStyle(color: Colors.black),
                    ),
                    leading: const Icon(
                      Icons.movie,
                      color: Colors.black26,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, EditGenre.routeName,
                                  arguments: genre);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black45,
                              size: 20,
                            )),
                        IconButton(
                            onPressed: () {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  title: 'Hapus Genre',
                                  text:
                                      'Yakin ingin menghapus genre ${genre['genre']} ?',
                                  confirmBtnText:
                                      isloading ? 'Mengapus Data...' : 'Hapus',
                                  cancelBtnText: 'Batal',
                                  confirmBtnColor: Colors.red,
                                  onConfirmBtnTap: () {
                                    deleteGenreResponse(genre['id_genre']);
                                    Navigator.of(context).pop();
                                  },
                                  animType: QuickAlertAnimType.slideInDown);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black45,
                              size: 20,
                            ))
                      ],
                    ));
              },
              itemCount: dataGenre.length,
            ),
    );
  }

  void getData() async {
    try {
      setState(() {
        isloading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      Response response;
      response = await dio.get(getAllgenre);
      if (response.data['status'] == true) {
        dataGenre = response.data['data'];
      } else {
        setState(() {
          isloading = false;
        });
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
        isloading = false;
      });
    }
  }

  void deleteGenreResponse(int id) async {
    try {
      setState(() {
        isloading = true;
      });
      Response response;
      response = await dio.delete(hapusGenre + id.toString());
      if (response.data['status'] == true) {
        toastification.show(
          context: context,
          title: Text(response.data['msg']),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 3),
          style: ToastificationStyle.fillColored,
        );
        Navigator.pushNamed(context, Genre.routeName);
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
        isloading = false;
      });
    }
  }
}
