import 'package:flutter/material.dart';
import 'package:flutter_uilogin/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class TextfieldEmailWidget extends StatefulWidget {
  const TextfieldEmailWidget(
      {super.key, required this.controller, required this.style});
  final TextEditingController controller;
  final TextStyle style;

  @override
  State<TextfieldEmailWidget> createState() => _TextfieldEmailWidgetState();
}

class _TextfieldEmailWidgetState extends State<TextfieldEmailWidget> {
  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: widget.style.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty || value == "") {
              return "Email can't be empty";
            } else if (!value.trim().contains("@")) {
              return "Email not valid";
            }
            return null;
          },
          onSaved: (value) {
            loadAuth.enteredEmail = value!;
          },
          style: widget.style.copyWith(
            color: Colors.black, // Warna teks input menjadi hitam
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Masukan Email....",
            hintStyle: widget.style.copyWith(
              color: const Color.fromARGB(
                  255, 36, 26, 26), // Warna hint (placeholder) menjadi abu-abu
            ),
          ),
        ),
      ],
    );
  }
}
