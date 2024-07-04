import 'package:flutter/material.dart';
import 'package:flutter_uilogin/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class TextfieldPasswordWidget extends StatefulWidget {
  const TextfieldPasswordWidget(
      {super.key, required this.controller, required this.style});
  final TextEditingController controller;
  final TextStyle style;

  @override
  State<TextfieldPasswordWidget> createState() =>
      _TextfieldPasswordWidgetState();
}

class _TextfieldPasswordWidgetState extends State<TextfieldPasswordWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: widget.style.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          validator: (value) {
            if (value!.trim().isEmpty || value == "") {
              return "Password can't be empty";
            } else if (value.trim().length < 6) {
              return "Password should be more than 6 characters";
            }
            return null;
          },
          onSaved: (value) {
            loadAuth.enteredPassword = value!;
          },
          style: widget.style.copyWith(
            color: Colors.black, // Warna teks input menjadi hitam
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Masukan Password....",
            hintStyle: widget.style.copyWith(
              color: const Color.fromARGB(
                  255, 43, 31, 31), // Warna hint (placeholder) menjadi abu-abu
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: const Icon(Icons.remove_red_eye_rounded),
              color: Colors.black, // Warna ikon mata yang akan ditampilkan
            ),
          ),
        ),
      ],
    );
  }
}
