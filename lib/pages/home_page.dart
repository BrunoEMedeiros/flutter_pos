import 'package:flutter/material.dart';
import 'package:projeto/repository/viagens_repository.dart';
import 'package:intl/intl.dart';
import 'package:projeto/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              return ExpansionTile(
                                // key: viagem.id,
                                onExpansionChanged: (isExpanded) {
                                  debugPrint(
                                      "Expansion state changed to $isExpanded");
                                },
                                title: Text(
                                  viagem.destination,
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
                                            "Ida: ${DateFormat('dd-MM-yyyy').format(viagem.startDate)}"),
                                      ),
                                      const SizedBox(width: 30),
                                      SizedBox(
                                        height: 30,
                                        child: Text(
                                            "Volta: ${DateFormat('dd-MM-yyyy').format(viagem.endDate)}"),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: Text(viagem.status),
                                      ),
                                      const SizedBox(width: 30),
                                      OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide.none,
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                              );
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
          bottomNavigationBar: const BottomNavBar());
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
