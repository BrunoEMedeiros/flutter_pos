import 'dart:async';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class FormEmail extends StatefulWidget {
  final Function funcao;

  const FormEmail({super.key, required this.funcao});

  @override
  State<FormEmail> createState() => _FormEmailState();
}

class _FormEmailState extends State<FormEmail> {
  Future<bool> sendEmail(String email) async {
    try {
      Map<String, dynamic> request = {'email': email};
      final uri = Uri.parse("http://10.106.77.51:21035/auth/get-access-code");
      final response = await http.post(uri, body: request);
      if (response.statusCode == 201) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      debugPrint("Error to send email: $e");
      return Future.value(false);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _textEmail = TextEditingController();
  Color prefixIconColor = Colors.blue;
  bool error = false;

  @override
  Widget build(context) {
    try {
      return Material(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textEmail,
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Insira o email",
                    prefixIcon: const Icon(Icons.email),
                    prefixIconColor: prefixIconColor),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite o email";
                  } else if (!EmailValidator.validate(value.toString())) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final response = await sendEmail(_textEmail.text);
                    // debugPrint(response.toString());
                    if (response) {
                      setState(() {
                        error = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Codigo enviado para o seu email")));
                        prefixIconColor = Colors.blue;
                        widget.funcao(_textEmail.text);
                      });
                    } else {
                      //throw Exception("Error to send email");
                      setState(() {
                        error = true;
                      });
                    }
                  } else {
                    setState(() {
                      prefixIconColor = Colors.red;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30)),
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Visibility(
                  visible: error,
                  child: const Text(
                    "Ops, ocorreu um erro ao enviar para estre email",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ],
          ),
        ),
      );
    } catch (e) {
      return Column(
        children: [
          const Text("Error to handle widget"),
          Text(
            "$e",
            style: const TextStyle(
              fontSize: 20,
            ),
          )
        ],
      );
    }
  }
}
