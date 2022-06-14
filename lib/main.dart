import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetopesquisa/pages/auth_page.dart';
import 'package:projetopesquisa/pages/selecaoDomicilio.dart';

import 'firebase_options.dart';
import 'helper/helpers_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomeApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  static const String title = 'Pesquisa Domiciliar';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: HelpersAuth.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: title,
      home: const Login(),
    );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError){
          return const Center(child: Text("Erro ao logar!"));
        }else if(snapshot.hasData){
          return const SelecaoDomicilio();
        }else{
          return const AuthPage();
        }
      },
    ),
  );
}
