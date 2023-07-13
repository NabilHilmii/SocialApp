import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:untitled4/appku/HomePage.dart';
import 'package:social_app/HomePage.dart';

import 'package:social_app/NextPage.dart';
import 'package:social_app/sharedpref.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  String tokenTanpaSharedpref = "";

  @override
  Widget build(BuildContext context) {
    Future<void> login(BuildContext context) async {
      var dio = Dio();
      try {
        var response = await dio.post(
          "$baseUrl/login",
          data: {
            "email": emailController.text,
            "password": passwordController.text
          },
        );
        SharedPref.pref?.setString("token", response.data["data"]["token"]);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        );
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.toString(),
          ),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Text(
              "Welcome back! Glad to see you, Again!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 32,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter Your Email"),
            ),
            Container(
              height: 12,
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your Password",
                  suffixIcon: Icon(Icons.remove_red_eye)),
            ),
            Container(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password',
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black)),
                onPressed: () {
                  login(context);
                },
                child: const Text("Login"),
              ),
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.grey,
                  width: 120,
                  height: 2,
                ),
                Text("Or Login With"),
                Container(
                  color: Colors.grey,
                  width: 120,
                  height: 2,
                )
              ],
            ),
            Container(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 36,
                  child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png"),
                ),
                Container(
                  height: 36,
                  child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png"),
                ),
                Container(
                  height: 36,
                  child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/625px-Apple_logo_black.svg.png"),
                )
              ],
            ),
            Container(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account?"),
                Container(width: 12),
                Text(
                  "Register Now",
                  style: TextStyle(color: Colors.cyan),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
