import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/model/Viagens.dart';
import 'package:projeto/pages/diary_page.dart';
import 'package:projeto/widgets/form_trip.dart';
import 'package:projeto/widgets/status_text.dart';

class CardTrips extends StatefulWidget {
  final String token;
  final Function recarregarTela;
  final Viagem viagem;

  const CardTrips(
      {super.key,
      required this.token,
      required this.recarregarTela,
      required this.viagem});

  @override
  State<CardTrips> createState() => _CardTripsState();
}

class _CardTripsState extends State<CardTrips> {
  @override
  Widget build(BuildContext context) {
    try {
      return InkWell(
          onLongPress: () {
            setState(() {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return SizedBox(
                        height: 450,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
                          child: FormNewTrip(
                            token: widget.token,
                            recarregar: widget.recarregarTela,
                            viagem: widget.viagem,
                            edit: true,
                          ),
                        ));
                  });
            });
          },
          child: ExpansionTile(
            title: Text(
              widget.viagem.destination,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text(
                        "Ida: ${DateFormat('dd/MM/yyyy').format(widget.viagem.startDate)}"),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    height: 30,
                    child: Text(
                        "Volta: ${DateFormat('dd/MM/yyyy').format(widget.viagem.endDate)}"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatusText(status: widget.viagem.status),
                  const SizedBox(width: 30),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DiaryHome(
                            tripId: widget.viagem.id,
                            token: widget.token,
                            tripDescription: widget.viagem.destination);
                      }));
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Diario'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  )
                ],
              )
            ],
          ));
    } catch (e) {
      print(e);
      return const Text("Error to handle trip cards");
    }
  }
}
