import 'package:flutter/material.dart';
import 'package:movie_apps/auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String routeName = "/register_page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            ElevatedButton(
              onPressed: () {},
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
}