import 'package:flutter/material.dart';
import 'package:projeto/repository/viagens_repository.dart';
import 'package:intl/intl.dart';
import 'package:projeto/widgets/bottom_nav_bar.dart';
import 'package:projeto/widgets/form_trip.dart';
import 'package:projeto/widgets/status_text.dart';
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;
    });
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
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Text(
                    "Bem vindo a Odysseia",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Suas viagens",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FutureBuilder(
                      future: ViagensRepository.getViagens(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!.map((viagem) {
                              return InkWell(
                                  onLongPress: () {
                                    setState(() {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext builder) {
                                            return SizedBox(
                                                height: 450,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 25, 25, 25),
                                                  child: FormNewTrip(
                                                    token: token,
                                                    recarregar: attLista,
                                                    viagem: viagem,
                                                    edit: true,
                                                  ),
                                                ));
                                          });
                                    });
                                  },
                                  child: ExpansionTile(
                                    title: Text(
                                      viagem.destination,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: Text(
                                                "Ida: ${DateFormat('dd/MM/yyyy').format(viagem.startDate)}"),
                                          ),
                                          const SizedBox(width: 30),
                                          SizedBox(
                                            height: 30,
                                            child: Text(
                                                "Volta: ${DateFormat('dd/MM/yyyy').format(viagem.endDate)}"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StatusText(status: viagem.status),
                                          const SizedBox(width: 30),
                                          OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide.none,
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
            token: token,
            recarregar: attLista,
          ));
    } catch (e) {
      return Column(
        children: [
          const Text("Error to handle page"),
          Text(
            "$e",
            style: const TextStyle(
              fontSize: 20,
            ),
          )
        ],
      );
    }
  }
}
