import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:movie_apps/users/home_user.dart';
import 'package:toastification/toastification.dart';

class BeliMovie extends StatefulWidget {
  const BeliMovie({super.key});
  static String routeName = "/beli-movie";
  @override
  State<BeliMovie> createState() => _BeliMovieState();
}

class _BeliMovieState extends State<BeliMovie> {
  final dio = Dio();
  bool isloading = false;
  var total = 0.0;
  String? userId;
  int? movieID;
  var user;

  TextEditingController tittleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    tittleController.text = args['movie']['tittle'];
    priceController.text = args['movie']['price'].toString();
    movieID = args['movie']['id_movie'];
    userId = args['user']['username'];
    user = args['user'];

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
            const Text(
              "Beli Movie",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Image.network("$imageUrl/${args['movie']['image']}",
                width: 200, height: 200, fit: BoxFit.cover),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: tittleController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Nama Judul Film",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: priceController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Harga Film",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: jumlahController,
              decoration: const InputDecoration(
                labelText: "Jumlah Beli",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    total = double.parse(priceController.text) *
                        double.parse(value);
                    totalController.text = total.toString();
                  } else {}
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: totalController,
              decoration: const InputDecoration(
                labelText: "Total Beli",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 16,
            ),
            isloading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (jumlahController.text.isEmpty &&
                          jumlahController.text == '') {
                        toastification.show(
                            context: context,
                            title: const Text("Jumlah film tidak boleh kosong"),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored);
                      } else {
                        responseTransaksi();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: const Size.fromHeight(50)),
                    child: const Text(
                      "Beli Movie",
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

  void responseTransaksi() async {
    try {
      setState(() {
        isloading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      Response response;
      response = await dio.post(insertTransaksi, data: {
        "userID": userId,
        "movieID": movieID,
        "harga": priceController.text,
        "jumlah": jumlahController.text,
        "total": totalController.text
      });
      if (response.data['status'] == true) {
        toastification.show(
            context: context,
            title: Text(response.data['msg']),
            type: ToastificationType.success,
            autoCloseDuration: Duration(seconds: 3),
            style: ToastificationStyle.fillColored);
        Navigator.pushNamed(context, HomeUsers.routeName, arguments: user);
      }
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
