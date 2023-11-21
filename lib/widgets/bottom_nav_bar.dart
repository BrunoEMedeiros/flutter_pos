import 'package:flutter/material.dart';
import 'package:projeto/pages/registry_page.dart';
import 'package:projeto/widgets/form_trip.dart';

class BottomNavBar extends StatefulWidget {
  final String token;
  final Function recarregar;
  const BottomNavBar(
      {super.key, required this.token, required this.recarregar});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  // double heigthSheet = 300;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        iconSize: 30,
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(167, 170, 164, 1),
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
            if (currentIndex == 1) {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return SizedBox(
                        height: 450,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
                          child: FormNewTrip(
                            token: widget.token,
                            recarregar: widget.recarregar,
                            viagem: null,
                            edit: false,
                          ),
                        ));
                  });
            } else if (currentIndex == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const RegistrationPage();
              }));
            }
          });
        },
        items: const [
          BottomNavigationBarItem(label: "HOME", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "NOVA VIAGEM", icon: Icon(Icons.airplay_outlined)),
          BottomNavigationBarItem(
              label: "PERFIL", icon: Icon(Icons.account_circle))
        ]);
  }
}
