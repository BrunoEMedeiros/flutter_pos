import 'package:flutter/material.dart';

class FormNewTrip extends StatefulWidget {
  const FormNewTrip({super.key});

  @override
  State<FormNewTrip> createState() => _FormNewTripState();
}

class _FormNewTripState extends State<FormNewTrip> {
  final _formKey = GlobalKey<FormState>();
  final _textDestino = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
          ],
        ));
  }
}
