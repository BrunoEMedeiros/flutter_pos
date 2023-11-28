import 'package:flutter/material.dart';
import 'package:projeto/repository/diary_repository.dart';
import 'package:projeto/widgets/bottom_nav_bar.dart';
import 'package:projeto/widgets/cards_diary.dart';

class DiaryHome extends StatefulWidget {
  final int tripId;
  final String tripDescription;
  final String token;
  const DiaryHome(
      {super.key,
      required this.tripId,
      required this.token,
      required this.tripDescription});

  @override
  State<DiaryHome> createState() => _DiaryHomeState();
}

class _DiaryHomeState extends State<DiaryHome> {
  Future<void> attLista() async {
    setState(() {
      print("Lista atualizada");
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.width * 0.2,
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.width * 0.1),
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.tripDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).textScaleFactor * 40),
                  ),
                  Text(
                    "Diario de viagem",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 25),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FutureBuilder(
                      future: DiarysRepository.getDiarys(widget.tripId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!.map((diario) {
                              return CardDiary(
                                  token: widget.token,
                                  diary: diario,
                                  recarregar: attLista);
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          // The async operation has failed.
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // The async operation is still in progress.
                          return const CircularProgressIndicator();
                        }
                      })
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            tripId: widget.tripId,
            diaryMode: true,
            token: widget.token,
            recarregar: attLista,
          ));
    } catch (e) {
      return Text("Error to handle diary entrys: $e");
    }
  }
}
