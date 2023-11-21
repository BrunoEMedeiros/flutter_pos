import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:projeto/model/Viagens.dart';
import 'package:projeto/widgets/buttom_forms.dart';

class FormNewTrip extends StatefulWidget {
  final String token;
  final Function recarregar;
  final bool edit;
  final Viagem? viagem;
  const FormNewTrip({
    super.key,
    required this.token,
    required this.recarregar,
    required this.edit,
    required this.viagem,
  });

  @override
  State<FormNewTrip> createState() => _FormNewTripState();
}

class _FormNewTripState extends State<FormNewTrip> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _textDestino;
  late TextEditingController _textDataIda;
  late TextEditingController _textDataVolta;
  late String dropDownOption;
  Color prefixIconColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    // Definindo o valor inicial do controlador
    if (widget.viagem != null) {
      _textDestino = TextEditingController(text: widget.viagem!.destination);
      _textDataIda = TextEditingController(
          text: DateFormat("dd/MM/yyyy").format(widget.viagem!.startDate));
      _textDataVolta = TextEditingController(
          text: DateFormat("dd/MM/yyyy").format(widget.viagem!.endDate));
      dropDownOption = widget.viagem!.status;
    } else {
      _textDestino = TextEditingController();
      _textDataIda = TextEditingController();
      _textDataVolta = TextEditingController();
      dropDownOption = 'CREATED';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
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
                widget.viagem != null
                    ? DropdownButton<String>(
                        isDense: true,
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        iconSize: 30,
                        itemHeight: 50,
                        isExpanded: true,
                        value: dropDownOption,
                        onChanged: (String? value) {
                          setState(() {
                            dropDownOption = value!;
                          });
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'CREATED',
                            child: Center(
                                child: Text(
                              "Agendado",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                          DropdownMenuItem<String>(
                            value: 'INPROGRESS',
                            child: Center(
                                child: Text(
                              "Viajando",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                          DropdownMenuItem<String>(
                            value: 'FINISHED',
                            child: Center(
                                child: Text(
                              "Ja fui",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ],
                      )
                    : Container(),
                widget.viagem == null
                    ? ButtomForms(
                        id: null,
                        funcao: widget.recarregar,
                        textDataIda: _textDataIda,
                        formKey: _formKey,
                        textDataVolta: _textDataVolta,
                        textDestino: _textDestino,
                        editMode: false,
                        status: null,
                      )
                    : ButtomForms(
                        id: widget.viagem!.id,
                        funcao: widget.recarregar,
                        textDataIda: _textDataIda,
                        formKey: _formKey,
                        textDataVolta: _textDataVolta,
                        textDestino: _textDestino,
                        editMode: true,
                        status: widget.viagem!.status,
                      )
              ],
            )));
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
