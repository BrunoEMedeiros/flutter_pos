import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/repository/viagens_repository.dart';

class EditButtom extends StatefulWidget {
  final int id;
  final GlobalKey<FormState> formKey;
  final Function funcao;
  final TextEditingController destino;
  final TextEditingController dataIda;
  final TextEditingController dataVolta;
  final String status;
  const EditButtom(
      {super.key,
      required this.id,
      required this.formKey,
      required this.funcao,
      required this.destino,
      required this.dataIda,
      required this.dataVolta,
      required this.status});

  @override
  State<EditButtom> createState() => _EditButtomState();
}

class _EditButtomState extends State<EditButtom> {
  @override
  Widget build(BuildContext context) {
    try {
      return ElevatedButton(
          onPressed: () async {
            if (widget.formKey.currentState!.validate()) {
              DateTime ida =
                  DateFormat("dd/MM/yyyy").parse(widget.dataIda.text);
              String idaFormatada =
                  DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(ida);
              DateTime volta =
                  DateFormat("dd/MM/yyyy").parse(widget.dataVolta.text);
              String voltaFormatada =
                  DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(volta);

              idaFormatada += "Z";
              voltaFormatada += "Z";

              final response = await ViagensRepository.editTrip(
                  widget.id,
                  idaFormatada.trim(),
                  voltaFormatada.trim(),
                  widget.destino.text.trim(),
                  widget.status);
              if (response) {
                setState(() {
                  widget.funcao();
                  Navigator.pop(context);
                });
              }
            }
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 40),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)))),
          child: const Icon(
            Icons.edit,
            size: 35,
            weight: 300,
          ));
    } catch (e) {
      debugPrint("$e");
      throw Exception("Erro to handle buttom");
    }
  }
}
