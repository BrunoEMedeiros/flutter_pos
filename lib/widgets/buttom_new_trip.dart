import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/repository/viagens_repository.dart';

class ButtomForms extends StatefulWidget {
  final TextEditingController textDataIda;
  final GlobalKey<FormState> formKey;
  final TextEditingController textDataVolta;
  final TextEditingController textDestino;
  final Function funcao;

  const ButtomForms({
    super.key,
    required this.funcao,
    required this.textDataIda,
    required this.formKey,
    required this.textDataVolta,
    required this.textDestino,
  });

  @override
  State<ButtomForms> createState() => _ButtomFormsState();
}

class _ButtomFormsState extends State<ButtomForms> {
  Color prefixIconColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    try {
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

              final response = await ViagensRepository.newTrip(
                  idaFormatada.trim(),
                  voltaFormatada.trim(),
                  widget.textDestino.text.trim());
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
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 40),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)))),
          child: const Icon(
            Icons.flight,
            size: 35,
            weight: 300,
          ));
    } catch (e) {
      debugPrint("$e");
      throw Exception("Erro to handle buttom");
    }
  }
}
