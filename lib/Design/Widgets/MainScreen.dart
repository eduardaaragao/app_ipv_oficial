import 'package:app_ipv/Autentica%C3%A7%C3%A3o/LaunchScreen.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  Gestao gestor = Gestao("http://projecto-ipv.f2mobile.eu/", "GM_Servico.php");
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App QR Code - IPV',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            elevation: 0,
            color: Uteis.kWhite
        ),
        scaffoldBackgroundColor: Uteis.kWhite,
        fontFamily: 'Poppins',
      ),
      home: LaunchScreen(ref_gestor: gestor),
    );
  }
}
