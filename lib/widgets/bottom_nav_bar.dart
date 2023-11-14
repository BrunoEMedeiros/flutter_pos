import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
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
                    return Column(
                      children: [
                        const Text("Teste"),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "clique",
                            ))
                      ],
                    );
                  });
            } else if (currentIndex == 2) {
              // Navigator.pop(context, MaterialPageRoute(builder: (context) {
              //   return const HomePage();
              // }));
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
