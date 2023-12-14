import 'package:flutter/material.dart';
import 'package:projeto/repository/verify_respositoru.dart';
import 'package:projeto/widgets/bottom_nav_bar.dart';
import 'package:projeto/widgets/cards_trip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> attLista() async {
    setState(() {
      print("Lista atualizada");
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder(
          future: VerifyRepository.getToken(),
          builder: (context, snapshot) {
            debugPrint(snapshot.data);
            if (snapshot.hasData) {
              return Scaffold(
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.1,
                          MediaQuery.of(context).size.width * 0.2,
                          MediaQuery.of(context).size.width * 0.1,
                          MediaQuery.of(context).size.width * 0.1),
                      child: Column(
                        children: [
                          Text(
                            "Bem vindo a Odysseia",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        40),
                            // style: TextStyle(
                            //     fontSize: MediaQuery.of(context).textScaleFactor * 60,
                            //     fontWeight: FontWeight.bold),
                          ),
                          Text("Suas viagens",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          25)),
                          const SizedBox(
                            height: 50,
                          ),
                          CardTrips(
                              token: snapshot.data!, recarregarTela: attLista)
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: BottomNavBar(
                    diaryMode: false,
                    token: snapshot.data!,
                    recarregar: attLista,
                  ));
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Scaffold(body: Text('Carregando'));
            }
          });
    } catch (e) {
      return Column(
        children: [
          const Text("Error to handle page"),
          Text(
            "$e",
          )
        ],
      );
    }
  }
}
