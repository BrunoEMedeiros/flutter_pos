import 'package:flutter/material.dart';
import 'package:projeto/pages/home_page.dart';
import 'package:projeto/pages/registry_page.dart';
import 'package:projeto/widgets/form_diary.dart';
import 'package:projeto/widgets/form_trip.dart';

class BottomNavBar extends StatefulWidget {
  final int? tripId;
  final bool diaryMode;
  final String token;
  final Function recarregar;
  const BottomNavBar(
      {super.key,
      required this.token,
      required this.recarregar,
      required this.diaryMode,
      this.tripId});

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
            if (currentIndex == 0) {
              if (widget.diaryMode) {
                Navigator.pop(context);
              }
            }
            if (currentIndex == 1) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext builder) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: widget.diaryMode == false
                          ? FormNewTrip(
                              token: widget.token,
                              recarregar: widget.recarregar,
                              viagem: null,
                              edit: false,
                            )
                          : FormNewDiary(
                              tripId: widget.tripId!,
                              token: widget.token,
                              recarregar: widget.recarregar,
                              diario: null,
                              edit: false),
                    );
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
              label: "NOVA VIAGEM", icon: Icon(Icons.flight)),
          BottomNavigationBarItem(label: "SAIR", icon: Icon(Icons.exit_to_app))
        ]);
  }
}
