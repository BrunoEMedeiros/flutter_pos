import 'package:flutter/material.dart';
import 'package:projeto/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkEmail();
    super.initState();
  }

  Future<bool> checkEmail() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString("email", "teste");
      //await prefs.clear();
      final email = prefs.getString("email");
      debugPrint("email no storage: $email");
      return email == null || email.toString().isEmpty ? false : true;
    } catch (e) {
      debugPrint("Error on check localStorage: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'), // HUEHUE
          ],
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(0, 119, 182, 1),
            primaryColorLight: const Color.fromRGBO(144, 224, 239, 1),
          ),
          darkTheme: ThemeData(
              primaryColor: const Color.fromRGBO(3, 4, 94, 1),
              primaryColorLight: const Color.fromRGBO(2, 62, 138, 1)),
          home: FutureBuilder(
              future: checkEmail(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                  // return snapshot.data!
                  //     ? const HomePage()
                  //     : const RegistrationPage();
                } else if (snapshot.hasError) {
                  // The async operation has failed.
                  return Text('Error: ${snapshot.error}');
                } else {
                  // The async operation is still in progress.
                  return const CircularProgressIndicator();
                }
              }));
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
