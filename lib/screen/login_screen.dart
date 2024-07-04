import 'package:flutter/material.dart';
import 'package:flutter_uilogin/provider/auth_provider.dart';
import 'package:flutter_uilogin/widget/textfield/textfield_email_widget.dart';
import 'package:flutter_uilogin/widget/textfield/textfield_pass_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthProvider>(context);
    return Container(
      color: Colors.pinkAccent, // Mengubah warna background menjadi pink
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.pink.shade200,
                        Colors.pink.shade400,
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          loadAuth.islogin ? "LOGIN" : "REGISTER",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                            color:
                                Colors.black, // Ubah warna teks menjadi hitam
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 253, 91,
                                142), // Ubah warna background menjadi pink tua
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 163, 92, 116),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Form(
                            key: loadAuth.form,
                            child: Column(
                              children: [
                                if (loadAuth.islogin)
                                  SizedBox(
                                      height:
                                          0) // Untuk menghilangkan space jika login
                                else
                                  SizedBox(
                                      height:
                                          0), // Hapus widget ImagePickWidget() di sini
                                TextfieldEmailWidget(
                                  controller: email,
                                  style: TextStyle(
                                      color: Colors
                                          .black), // Ubah warna teks menjadi hitam
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextfieldPasswordWidget(
                                  controller: password,
                                  style: TextStyle(
                                      color: Colors
                                          .black), // Ubah warna teks menjadi hitam
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      loadAuth.submit();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 224, 158, 180),
                                    ),
                                    child: Text(
                                      loadAuth.islogin ? "  Login" : "Register",
                                      style: TextStyle(
                                        color: Colors
                                            .black, // Ubah warna teks tombol menjadi hitam
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      loadAuth.islogin = !loadAuth.islogin;
                                    });
                                  },
                                  child: Text(
                                    loadAuth.islogin
                                        ? "Tambah Akun"
                                        : "Sudah Punya Akun",
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Ubah warna teks tombol menjadi hitam
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
