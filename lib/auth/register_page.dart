import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_apps/api_service/api.dart';
import 'package:movie_apps/auth/login_page.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String routeName = "/register-page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final dio = Dio();

  bool isloading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
              "assets/images/user.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Registrasi Akun",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: fullnameController,
              decoration: const InputDecoration(
                labelText: "Full Nama",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Nomor Telepon",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            const SizedBox(
              height: 16,
            ),
            isloading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      if (usernameController.text.isEmpty &&
                          usernameController.text == '') {
                        toastification.show(
                            context: context,
                            title: const Text("Username tidak boleh kosong"),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored);
                      } else if (fullnameController.text.isEmpty &&
                          fullnameController.text == '') {
                        toastification.show(
                            context: context,
                            title: const Text("Nama tidak boleh kosong"),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored);
                      } else if (emailController.text.isEmpty &&
                          emailController.text == '') {
                        toastification.show(
                            context: context,
                            title: const Text("Email tidak boleh kosong"),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored);
                      } else if (passwordController.text.isEmpty &&
                          passwordController.text == '') {
                        toastification.show(
                            context: context,
                            title: const Text("Password tidak boleh kosong"),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored);
                      } else if (phoneController.text.isEmpty &&
                          phoneController.text == '') {
                        toastification.show(
                            context: context,
                            title:
                                const Text("Nomor Telepon tidak boleh kosong"),
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.fillColored);
                      } else {
                        registerResponse();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: const Size.fromHeight(50)),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Sudah punya akun ?'),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.routeName);
                    },
                    child: const Text('Login disini'))
              ],
            )
          ],
        ),
      ))),
    );
  }

  void registerResponse() async {
    try {
      setState(() {
        isloading = true;
      });
      await Future.delayed(const Duration(seconds: 3));
      Response response;
      response = await dio.post(register, data: {
        "username": usernameController.text,
        "full_name": fullnameController.text,
        "email": emailController.text,
        "no_telp": phoneController.text,
        "password": passwordController.text
      });
      if (response.data['status'] == true) {
        toastification.show(
            context: context,
            title: Text(response.data['msg']),
            type: ToastificationType.success,
            autoCloseDuration: Duration(seconds: 3),
            style: ToastificationStyle.fillColored);
        Navigator.pushNamed(context, LoginPage.routeName);
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
