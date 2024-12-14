import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_apps/admin/model/genre_model.dart';
import 'package:movie_apps/admin/movie/movie_admin.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:toastification/toastification.dart';

class UpdateMovie extends StatefulWidget {
  const UpdateMovie({super.key});
  static const routeName = '/update-movie';

  @override
  State<UpdateMovie> createState() => _UpdateMovieState();
}

class _UpdateMovieState extends State<UpdateMovie> {
  final dio = Dio();

  bool isloading = false;

  int? id_genre;
  String? genre;

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

  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          _imageBytes = imageBytes;
        });
      }
    } catch (e) {
      throw Exception("Failed to pick image : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    tittleController.text = args['tittle'];
    priceController.text = args['price'].toString();
    ratingController.text = args['rating'].toString();
    descriptionController.text = args['description'];
    genre = args['tb_genre']['genre'].toString();
    id_genre = args['tb_genre']['id_genre'];

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
              "Edit Movie",
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
                  id_genre = data?.id_genre;
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
                var text = _selectedGenre == null
                    ? genre.toString()
                    : _selectedGenre!.genre;
                return Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                pickImage();
              },
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
            _imageBytes != null
                ? Image.memory(
                    _imageBytes!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : Image.network("$imageUrl/${args['image']}",
                    width: 200, height: 200, fit: BoxFit.cover),
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
                      "Edit Movie",
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
//   void editResponse(int id, genre) async {
//     try {
//       setState(() {
//         isloading = true;
//       });
//       await Future.delayed(const Duration(seconds: 2));
//       FormData formData = FormData.fromMap({
//         'image': MultipartFile.fromBytes(_imageBytes!, filename: 'bebas.jpg'),
//         "tittle": tittleController.text,
//         "price": priceController.text,
//         "id_genre": id_genre.toString(),
//         "rating": ratingController.text,
//         "description": descriptionController.text
//       });
//       Response response;
//       response =
//           response = await dio.post(editMovie + id.toString(), data: formData);
//       if (response.data['status'] == true) {
//         toastification.show(
//             context: context,
//             title: Text(response.data['msg']),
//             type: ToastificationType.success,
//             autoCloseDuration: Duration(seconds: 3),
//             style: ToastificationStyle.fillColored);
//         Navigator.pushNamed(context, MovieAdmin.routeName);
//       } else {
//         toastification.show(
//             context: context,
//             title: Text(response.data['msg']),
//             type: ToastificationType.error,
//             style: ToastificationStyle.fillColored);
//       }
//       ;
//     } catch (e) {
//       toastification.show(
//           context: context,
//           title: Text("Terjadi Kesalahan pada Server"),
//           type: ToastificationType.error,
//           autoCloseDuration: const Duration(seconds: 3),
//           style: ToastificationStyle.fillColored);
//     } finally {
//       setState(() {
//         isloading = false;
//       });
//     }
//   }
// }
