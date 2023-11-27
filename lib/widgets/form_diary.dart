import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto/model/Diario.dart';
import 'package:projeto/repository/diary_repository.dart';
import 'package:projeto/widgets/buttom_edit_diary.dart';
import 'package:projeto/widgets/buttom_new_diary.dart';

class FormNewDiary extends StatefulWidget {
  final int? tripId;
  final String token;
  final Function recarregar;
  final bool edit;
  final Diario? diario;
  const FormNewDiary(
      {super.key,
      required this.token,
      required this.recarregar,
      required this.edit,
      this.diario,
      required this.tripId});

  @override
  State<FormNewDiary> createState() => _FormNewDiaryState();
}

class _FormNewDiaryState extends State<FormNewDiary> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _textDate;
  late TextEditingController _textDescription;
  late TextEditingController _textLocation;
  Color prefixIconColor = Colors.blue;

  @override
  void initState() {
    // Definindo o valor inicial do controlador
    if (widget.diario != null) {
      _textDate = TextEditingController(
          text: DateFormat("dd/MM/yyyy").format(widget.diario!.date));
      _textDescription =
          TextEditingController(text: widget.diario!.description);
      _textLocation = TextEditingController(text: widget.diario!.location);
    } else {
      _textDate = TextEditingController();
      _textDescription = TextEditingController();
      _textLocation = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
          padding: const EdgeInsets.all(18),
          child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        minLines: 1,
                        maxLines: 5,
                        controller: _textDescription,
                        style: const TextStyle(fontSize: 22),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Digite a descricao",
                            prefixIcon: const Icon(Icons.book),
                            prefixIconColor: prefixIconColor),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              prefixIconColor = Colors.red;
                            });
                            return "Digite a descricao";
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
                        controller: _textLocation,
                        style: const TextStyle(fontSize: 22),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Escreva a localizacao",
                            prefixIcon: const Icon(Icons.man_outlined),
                            prefixIconColor: prefixIconColor),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              prefixIconColor = Colors.red;
                            });
                            return "Escreva a localizacao";
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
                          controller: _textDate,
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
                              labelText: 'Data',
                              focusColor: Colors.blue,
                              prefixIconColor: prefixIconColor,
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  await _selectDate();
                                },
                              )),
                          onTap: () async {
                            await _selectDate();
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ]),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.edit == false
                              ? ButtomNewDiary(
                                  textDate: _textDate,
                                  formKey: _formKey,
                                  textDescription: _textDescription,
                                  textLocation: _textLocation,
                                  funcao: widget.recarregar,
                                  tripId: widget.tripId!)
                              : ButtomEditDiary(
                                  id: widget.diario!.id,
                                  tripId: widget.diario!.tripId,
                                  textDate: _textDate,
                                  formKey: _formKey,
                                  textDescription: _textDescription,
                                  textLocation: _textLocation,
                                  funcao: widget.recarregar),
                          const SizedBox(
                            width: 20,
                          ),
                          Visibility(
                            visible: widget.edit,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onLongPress: () async {
                                final response =
                                    await DiarysRepository.deleteDiary(
                                        widget.diario!.id,
                                        widget.diario!.tripId);
                                if (response) {
                                  setState(() {
                                    widget.recarregar();
                                    prefixIconColor = Colors.blue;
                                    Navigator.pop(context);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ))));
    } catch (e) {
      return Text("Error to handle form: $e");
    }
  }

  Future<void> _selectDate() async {
    try {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          locale: const Locale('pt', 'BR'));

      if (picked != null) {
        setState(() {
          // String data = picked.toString().split(" ")[0];
          _textDate.text = DateFormat('dd/MM/yyyy').format(picked);
        });
      }
    } catch (e) {
      debugPrint("$e");
      throw Exception("Error to pick a date");
    }
  }
}
