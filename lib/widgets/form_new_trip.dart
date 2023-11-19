import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormNewTrip extends StatefulWidget {
  const FormNewTrip({super.key});

  @override
  State<FormNewTrip> createState() => _FormNewTripState();
}

class _FormNewTripState extends State<FormNewTrip> {
  final _formKey = GlobalKey<FormState>();
  final _textDestino = TextEditingController();
  final _textDataIda = TextEditingController();
  final _textDataVolta = TextEditingController();
  Color prefixIconColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _textDestino,
              style: const TextStyle(fontSize: 22),
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Digite o destino",
                  prefixIcon: const Icon(Icons.airplane_ticket),
                  prefixIconColor: prefixIconColor),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    prefixIconColor = Colors.red;
                  });
                  return "Digite o destino";
                }
                if (prefixIconColor == Colors.red) {
                  setState(() {
                    prefixIconColor = Colors.blue;
                  });
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: _textDataIda,
                keyboardType: TextInputType.none,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      prefixIconColor = Colors.red;
                    });
                    return "Escolha uma data";
                  }
                  if (prefixIconColor == Colors.red) {
                    setState(() {
                      prefixIconColor = Colors.blue;
                    });
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Data da ida',
                    focusColor: Colors.blue,
                    prefixIconColor: prefixIconColor,
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await _selectDateIda();
                      },
                    )),
                onTap: () async {
                  await _selectDateIda();
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ]),
            const SizedBox(height: 20),
            TextFormField(
                controller: _textDataVolta,
                keyboardType: TextInputType.none,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      prefixIconColor = Colors.red;
                    });
                    return "Escolha uma data";
                  }
                  if (value == _textDataIda.text ||
                      value.compareTo(_textDataIda.text) < 0) {
                    return "Data de volta invalido";
                  }
                  if (prefixIconColor == Colors.red) {
                    setState(() {
                      prefixIconColor = Colors.blue;
                    });
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Data da volta',
                    focusColor: Colors.blue,
                    prefixIconColor: prefixIconColor,
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await _selectDateVolta();
                      },
                    )),
                onTap: () async {
                  await _selectDateVolta();
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ]),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //final response = await sendEmail(_textEmail.text);
                  // debugPrint(response.toString());
                  setState(() {
                    prefixIconColor = Colors.blue;
                    Navigator.pop(context);
                  });
                } else {
                  setState(() {
                    prefixIconColor = Colors.red;
                  });
                }
              },
              // style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //         vertical: 10, horizontal: 100)),
              child: const Text(
                'Viajar',
                style: TextStyle(fontSize: 22),
              ),
            )
          ],
        ));
  }

  Future<void> _selectDateIda() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        locale: const Locale('pt', 'BR'));

    if (picked != null) {
      setState(() {
        // String data = picked.toString().split(" ")[0];
        _textDataIda.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectDateVolta() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        locale: const Locale('pt', 'BR'));

    if (picked != null) {
      setState(() {
        // String data = picked.toString().split(" ")[0];
        _textDataVolta.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
}
