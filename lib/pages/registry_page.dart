import 'package:flutter/material.dart';
import 'package:projeto/pages/home_page.dart';
import 'package:projeto/widgets/form_email.dart';
import 'package:projeto/widgets/form_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:localstorage/localstorage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  void initState() {
    clearEmail();
    super.initState();
  }

  bool registryMode = false;
  late String userEmail;

  Future<bool> clearEmail() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      debugPrint("Error to clear shared_preferences: $e");
      return false;
    }
  }

  void checkTokenMode(String email) {
    try {
      setState(() {
        registryMode = !registryMode;
        userEmail = email;
        debugPrint("Email do usuario: $userEmail");
      });
    } catch (e) {
      debugPrint("Error to update registryMode: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      // LocalStorage("odysseia").clear();
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Odysseia",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Insira um email e comece a usar!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 60),
                FutureBuilder(
                    future: clearEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return registryMode
                            ? FormToken(
                                tela: const HomePage(), email: userEmail)
                            : FormEmail(funcao: checkTokenMode);
                      } else if (snapshot.hasError) {
                        // The async operation has failed.
                        return Text(
                            'Error to clean preferences: ${snapshot.error}');
                      } else {
                        // The async operation is still in progress.
                        return const CircularProgressIndicator();
                      }
                    })
              ],
            ),
          ),
        ),
      );
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
