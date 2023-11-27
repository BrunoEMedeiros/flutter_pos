import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/repository/diary_repository.dart';

class ButtomNewDiary extends StatefulWidget {
  final int tripId;
  final TextEditingController textDate;
  final GlobalKey<FormState> formKey;
  final TextEditingController textDescription;
  final TextEditingController textLocation;
  final Function funcao;
  const ButtomNewDiary(
      {super.key,
      required this.textDate,
      required this.formKey,
      required this.textDescription,
      required this.textLocation,
      required this.funcao,
      required this.tripId});

  @override
  State<ButtomNewDiary> createState() => _ButtomNewDiaryState();
}

class _ButtomNewDiaryState extends State<ButtomNewDiary> {
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

              final response = await DiarysRepository.newDiaryEntry(
                  widget.tripId,
                  dateFormatada,
                  widget.textLocation.text,
                  widget.textDescription.text);
              if (response) {
                setState(() {
                  widget.funcao();
                  Navigator.pop(context);
                });
              }
            }
          },
          child: const Icon(
            Icons.save,
            size: 20,
          ));
    } catch (e) {
      debugPrint("$e");
      throw Exception("Erro to handle buttom");
    }
  }
}