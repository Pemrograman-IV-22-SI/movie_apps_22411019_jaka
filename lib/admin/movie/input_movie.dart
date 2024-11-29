import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/admin/model/genre_model.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:toastification/toastification.dart';
import 'package:dropdown_search/dropdown_search.dart';

class InputMovie extends StatefulWidget {
  const InputMovie({super.key});
  static const routeName = '/input-movie';

  @override
  State<InputMovie> createState() => _InputMovieState();
}

class _InputMovieState extends State<InputMovie> {
  final dio = Dio();

  bool isloading = false;

  TextEditingController tittleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GenreModel? _selectedGenre;

  Future<List<GenreModel>> getData() async {
    try {
      var response = await Dio().get(getAllgenre);
      final data = response.data["data"];
      if (data != null) {
        return GenreModel.fromJsonList(data);
      }
    } catch (e) {
      throw Exception('Terjadi Kesalahan : $e');
    }
    return [];
  }

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
              "assets/images/movie.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Input Movie",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: tittleController,
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
              controller: ratingController,
              decoration: const InputDecoration(
                labelText: "Rating Film",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Deskripsi Film",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            const SizedBox(
              height: 16,
            ),
            DropdownSearch<GenreModel>(
              popupProps: PopupProps.dialog(
                itemBuilder:
                    (BuildContext context, GenreModel item, bool isDisabled) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      title: Text(item.genre),
                      leading: CircleAvatar(child: Text(item.genre[0])),
                    ),
                  );
                },
                showSearchBox: true,
                searchFieldProps: const TextFieldProps(
                  decoration: InputDecoration(
                    hintText: "Search Genre...",
                  ),
                ),
              ),
              asyncItems: (String? filter) => getData(),
              itemAsString: (GenreModel? item) => item?.userAsString() ?? "",
              onChanged: (GenreModel? data) {
                setState(() {
                  _selectedGenre = data;
                });
              },
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Select Genre",
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              selectedItem: _selectedGenre,
              dropdownBuilder:
                  (BuildContext context, GenreModel? selectedItem) {
                return Text(
                  selectedItem?.genre ?? "Select Genre",
                  style: const TextStyle(
                    color: Colors.black, // Warna teks yang dipilih
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  minimumSize: const Size.fromHeight(50)),
              child: const Text(
                "Pilih Gambar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            isloading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      // if (tittleController.text.isEmpty &&
                      //     tittleController.text == '') {
                      //   toastification.show(
                      //       context: context,
                      //       title: const Text("Judul film tidak boleh kosong"),
                      //       autoCloseDuration: const Duration(seconds: 3),
                      //       type: ToastificationType.error,
                      //       style: ToastificationStyle.fillColored);
                      // } else {
                      //   // inputResponse();
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: const Size.fromHeight(50)),
                    child: const Text(
                      "Input Movie",
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
}
