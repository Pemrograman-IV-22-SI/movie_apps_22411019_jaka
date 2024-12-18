import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:movie_apps/users/home_user.dart';
import 'package:toastification/toastification.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});
  static const routeName = '/transaksi-user';

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final dio = Dio();
  bool isloading = false;
  var dataTransaksi = [];
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
                  Navigator.pushNamed(context, HomeUsers.routeName);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            Text("Transaksi", style: TextStyle(color: Colors.white)),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 171, 36),
      ),
      backgroundColor: Colors.white,
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                var transaksi = dataTransaksi[index];
                return ListTile(
                    title: Text(
                      transaksi['tb_movie']['tittle'],
                      style: const TextStyle(color: Colors.black),
                    ),
                    leading: const Icon(
                      Icons.movie,
                      color: Colors.black26,
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Harga Movie : Rp. ${transaksi['harga']}"),
                        Text("Jumlah Beli : Rp. ${transaksi['jumlah']}"),
                        Text("Total Beli : Rp. ${transaksi['harga']}"),
                      ],
                    ));
              },
              itemCount: dataTransaksi.length,
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
      response = await dio.get(getAllTransaksi);
      if (response.data['status'] == true) {
        dataTransaksi = response.data['data'];
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
}
