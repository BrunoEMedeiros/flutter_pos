import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/repository/viagens_repository.dart';

class ButtomForms extends StatefulWidget {
  final int? id;
  final TextEditingController textDataIda;
  final GlobalKey<FormState> formKey;
  final TextEditingController textDataVolta;
  final TextEditingController textDestino;
  final String? status;
  final Function funcao;
  final bool editMode;

  const ButtomForms(
      {super.key,
      required this.funcao,
      required this.textDataIda,
      required this.formKey,
      required this.textDataVolta,
      required this.textDestino,
      required this.editMode,
      required this.status,
      required this.id});

  @override
  State<ButtomForms> createState() => _ButtomFormsState();
}

class _ButtomFormsState extends State<ButtomForms> {
  Color prefixIconColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (widget.formKey.currentState!.validate()) {
          DateTime ida =
              DateFormat("dd/MM/yyyy").parse(widget.textDataIda.text);
          String idaFormatada =
              DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(ida);
          DateTime volta =
              DateFormat("dd/MM/yyyy").parse(widget.textDataVolta.text);
          String voltaFormatada =
              DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(volta);

          idaFormatada += "Z";
          voltaFormatada += "Z";

          if (widget.editMode == false) {
            final response = await ViagensRepository.newTrip(
                idaFormatada, voltaFormatada, widget.textDestino.text);
            if (response) {
              setState(() {
                widget.funcao();
                prefixIconColor = Colors.blue;
                Navigator.pop(context);
              });
            } else {
              setState(() {
                prefixIconColor = Colors.red;
              });
            }
          } else {
            final response = await ViagensRepository.editTrip(
                widget.id!,
                idaFormatada,
                voltaFormatada,
                widget.textDestino.text,
                widget.status!);
            if (response) {
              setState(() {
                widget.funcao();
                prefixIconColor = Colors.blue;
                Navigator.pop(context);
              });
            } else {
              setState(() {
                prefixIconColor = Colors.red;
              });
            }
          }
        }
      },
      child: !widget.editMode
          ? const Text(
              'Viajar',
              style: TextStyle(fontSize: 22),
            )
          : const Text(
              'Atualizar',
              style: TextStyle(fontSize: 22),
            ),
    );
  }
}
