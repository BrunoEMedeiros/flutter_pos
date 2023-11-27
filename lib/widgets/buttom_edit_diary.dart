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
  const ButtomEditDiary(
      {super.key,
      required this.id,
      required this.tripId,
      required this.textDate,
      required this.formKey,
      required this.textDescription,
      required this.textLocation,
      required this.funcao});

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
                  dateFormatada,
                  widget.textLocation.text,
                  widget.textLocation.text);
              if (response) {
                setState(() {
                  widget.funcao();
                  Navigator.pop(context);
                });
              }
            }
          },
          child: const Icon(Icons.edit));
    } catch (e) {
      debugPrint("$e");
      throw Exception("Error to handle buttom");
    }
  }
}
