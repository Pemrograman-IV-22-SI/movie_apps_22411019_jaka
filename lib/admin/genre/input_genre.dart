import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/admin/genre/genre.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:toastification/toastification.dart';

class InputGenre extends StatefulWidget {
  const InputGenre({super.key});
  static const routeName = '/input-genre';

  @override
  State<InputGenre> createState() => _InputGenreState();
}

class _InputGenreState extends State<InputGenre> {
  final dio = Dio();

  bool isloading = false;

  TextEditingController genreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/genre.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Input Genre",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: genreController,
              decoration: const InputDecoration(
                labelText: "Nama Genre",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16,
            ),
            isloading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (genreController.text.isEmpty &&
                          genreController.text == '') {
                        toastification.show(
                            context: context,
                            title: const Text("Genre tidak boleh kosong"),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored);
                      } else {
                        inputResponse();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: const Size.fromHeight(50)),
                    child: const Text(
                      "Input",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ))),
    );
  }

  void inputResponse() async {
    try {
      setState(() {
        isloading = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      Response response;
      response = await dio.post(insertGenre, data: {
        "genre": genreController.text,
      });
      if (response.data['status'] == true) {
        toastification.show(
            context: context,
            title: Text(response.data['msg']),
            type: ToastificationType.success,
            autoCloseDuration: Duration(seconds: 3),
            style: ToastificationStyle.fillColored);
        Navigator.pushNamed(context, Genre.routeName);
      } else {
        toastification.show(
            context: context,
            title: Text(response.data['msg']),
            type: ToastificationType.error,
            style: ToastificationStyle.fillColored);
      }
      ;
    } catch (e) {
      toastification.show(
          context: context,
          title: Text("Terjadi Kesalahan pada Server"),
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
