import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/repository/diary_repository.dart';

class ButtomEditDiary extends StatefulWidget {
  final int id;
  final int tripId;
  final TextEditingController textDate;
  final GlobalKey<FormState> formKey;
  final TextEditingController textDescription;
  final TextEditingController textLocation;
  final Function funcao;
  final File? imagem;

  const ButtomEditDiary(
      {super.key,
      required this.id,
      required this.tripId,
      required this.textDate,
      required this.formKey,
      required this.textDescription,
      required this.textLocation,
      required this.funcao,
      this.imagem});

  @override
  State<ButtomEditDiary> createState() => _ButtomEditDiaryState();
}

class _ButtomEditDiaryState extends State<ButtomEditDiary> {
  @override
  Widget build(BuildContext context) {
    try {
      return ElevatedButton(
          onPressed: () async {
            if (widget.formKey.currentState!.validate()) {
              DateTime date =
                  DateFormat("dd/MM/yyyy").parse(widget.textDate.text);
              String dateFormatada =
                  DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(date);

              dateFormatada += "Z";

              final response = await DiarysRepository.editDiary(
                  widget.id,
                  widget.tripId,
                  dateFormatada.trim(),
                  widget.textLocation.text.trim(),
                  widget.textDescription.text.trim());
              if (response) {
                if (widget.imagem != null) {
                  debugPrint("Entrando para cad imagem!");
                  final resImg = await DiarysRepository.newImageDiary(
                      widget.tripId, widget.id, widget.imagem!);
                  if (resImg) {
                    setState(() {
                      widget.funcao();
                      Navigator.pop(context);
                    });
                  }
                } else {
                  setState(() {
                    widget.funcao();
                    Navigator.pop(context);
                  });
                }
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
      throw Exception("Error to handle buttom");
    }
  }
}
