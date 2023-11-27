import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/model/Diario.dart';
import 'package:projeto/widgets/form_diary.dart';

class CardDiary extends StatefulWidget {
  final String token;
  final Diario diary;
  final Function recarregar;
  const CardDiary(
      {super.key,
      required this.token,
      required this.diary,
      required this.recarregar});

  @override
  State<CardDiary> createState() => _CardDiaryState();
}

class _CardDiaryState extends State<CardDiary> {
  @override
  Widget build(BuildContext context) {
    try {
      return GestureDetector(
          onLongPress: () {
            setState(() {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext builder) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: FormNewDiary(
                            tripId: widget.diary.tripId,
                            token: widget.token,
                            recarregar: widget.recarregar,
                            edit: true,
                            diario: widget.diary,
                          )),
                    );
                  });
            });
          },
          child: ExpansionTile(
            title: Text(
              DateFormat('dd/MM/yyyy').format(widget.diary.date),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50, child: Text(widget.diary.description)),
                  const SizedBox(width: 30),
                  SizedBox(height: 50, child: Text(widget.diary.location)),
                ],
              ),
            ],
          ));
    } catch (e) {
      return Text("Erro to handle diary`s cards: $e");
    }
  }
}
