import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/model/Viagens.dart';
import 'package:projeto/pages/diary_page.dart';
import 'package:projeto/repository/viagens_repository.dart';
import 'package:projeto/widgets/form_trip.dart';
import 'package:projeto/widgets/status_text.dart';

class CardTrips extends StatefulWidget {
  final String token;
  final Function recarregarTela;

  const CardTrips({
    super.key,
    required this.token,
    required this.recarregarTela,
  });

  @override
  State<CardTrips> createState() => _CardTripsState();
}

class _CardTripsState extends State<CardTrips> {
  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder(
          future: ViagensRepository.getViagens(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!.map((viagem) {
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
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: FormNewTrip(
                                        token: widget.token,
                                        recarregar: widget.recarregarTela,
                                        viagem: viagem,
                                        edit: true,
                                      ),
                                    ));
                              });
                        });
                      },
                      child: ExpansionTile(
                        // shape: const OutlineInputBorder(
                        //     borderRadius: BorderRadius.vertical(
                        //         top: Radius.circular(10), bottom: Radius.circular(10))),
                        title: Text(
                          viagem.destination,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 25),
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                                child: Text(
                                    "Ida: ${DateFormat('dd/MM/yyyy').format(viagem.startDate)}",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            18)),
                              ),
                              const SizedBox(width: 30),
                              SizedBox(
                                height: 30,
                                child: Text(
                                    "Volta: ${DateFormat('dd/MM/yyyy').format(viagem.endDate)}",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            18)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StatusText(status: viagem.status),
                              const SizedBox(width: 30),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DiaryHome(
                                        tripId: viagem.id,
                                        token: widget.token,
                                        tripDescription: viagem.destination);
                                  }));
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide.none,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Diario',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                18)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.arrow_forward),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ));
                }).toList(),
              );
            } else if (snapshot.hasError) {
              // The async operation has failed.
              return Text('Error: ${snapshot.error}');
            } else {
              // The async operation is still in progress.
              return const CircularProgressIndicator();
            }
          });
    } catch (e) {
      print(e);
      return const Text("Error to handle trip cards");
    }
  }
}
