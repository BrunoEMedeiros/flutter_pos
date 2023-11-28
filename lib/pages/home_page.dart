import 'package:flutter/material.dart';
import 'package:projeto/repository/viagens_repository.dart';
import 'package:projeto/widgets/bottom_nav_bar.dart';
import 'package:projeto/widgets/cards_trip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = '';

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        token = prefs.getString('token')!;
      });
    } catch (e) {
      print("Erro to get token on preferences: $e");
    }
  }

  Future<void> attLista() async {
    setState(() {
      print("Lista atualizada");
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('token: $token');
    try {
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
                        fontSize: MediaQuery.of(context).textScaleFactor * 40),
                    // style: TextStyle(
                    //     fontSize: MediaQuery.of(context).textScaleFactor * 60,
                    //     fontWeight: FontWeight.bold),
                  ),
                  Text("Suas viagens",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).textScaleFactor * 25)),
                  const SizedBox(
                    height: 50,
                  ),
                  FutureBuilder(
                      future: ViagensRepository.getViagens(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!.map((viagem) {
                              return CardTrips(
                                  token: token,
                                  recarregarTela: attLista,
                                  viagem: viagem);
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
            diaryMode: false,
            token: token,
            recarregar: attLista,
          ));
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
