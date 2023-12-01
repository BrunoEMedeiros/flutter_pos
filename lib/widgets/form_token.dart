import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto/utils.dart';

class FormToken extends StatefulWidget {
  final Widget tela;
  final String email;

  const FormToken({super.key, required this.tela, required this.email});

  @override
  State<FormToken> createState() => _FormTokenState();
}

class _FormTokenState extends State<FormToken> {
  final _formKey = GlobalKey<FormState>();
  final _textCode = TextEditingController();
  Color prefixIconColor = Colors.blue;
  bool error = false;
  bool isLoading = false;

  // /Future<String?>
  Future<String?> verifyToken(String email, String token) async {
    try {
      Map<String, dynamic> request = {'email': email, "code": token};
      final uri = Uri.parse("http://$host:21035/auth/validate-access-code");
      final response = await http.post(uri, body: request);
      if (response.statusCode == 201) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> data = jsonDecode(response.body);
        await prefs.setString("email", email);
        await prefs.setString("token", data["token"]);
        return data["token"];
      } else {
        return Future.value(null);
      }
    } catch (e) {
      debugPrint("Error to verify token: $e");
      return Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Material(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textCode,
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Insira o codigo",
                    prefixIcon: const Icon(Icons.key),
                    prefixIconColor: prefixIconColor),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite o codigo!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          final response =
                              await verifyToken(widget.email, _textCode.text);
                          if (response != null) {
                            setState(() {
                              isLoading = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Bem vindo!")));
                              prefixIconColor = Colors.blue;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return widget.tela;
                              }));
                            });
                          } else {
                            //throw Exception("Error verify token");
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
                        'Validar',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
              const SizedBox(height: 20),
              Visibility(
                  visible: error,
                  child: const Text(
                    "Ops, ocorreu um erro ao verificar seu codigo",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ],
          ),
        ),
      );
    } catch (e) {
      return Text("Erro to handle widget: $e");
    }
  }
}
