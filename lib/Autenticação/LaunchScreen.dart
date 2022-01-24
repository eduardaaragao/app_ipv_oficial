import 'package:app_ipv/Design/Bot%C3%B5es/BotaoDark.dart';
import 'package:app_ipv/Design/Bot%C3%B5es/BotaoLight.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'LoginScreen.dart';


/*--------------------------- App Launch Screen ---------------------------*/

class LaunchScreen extends StatefulWidget {
  final Gestao ref_gestor;
  LaunchScreen({this.ref_gestor});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return LaunchScreenWidget();
  }

  /*--------------------------------------------------------------------------*/
  Widget LaunchScreenWidget()
  {
    return Scaffold(
      body: BodyLaunchScreen(),
    );
  }

  /*--------------------------------------------------------------------------*/
  Widget BodyLaunchScreen(){
    return Center(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Uteis.kSplashPhoto),
              Column(
                children: [
                  Text(
                    "A nova maneira de organizar-se.",
                    style: Uteis.kHeaderStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Reúna suas aulas, suas disciplinas e horários em um só aplicativo.',
                    style: Uteis.kDescriptionStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BotaoDark(
                      press: () => {irParaLogin('Professor')},
                      text: 'Sou Professor'),
                  const SizedBox(width: 15),
                  BotaoLight(
                      press: () => {irParaLogin('Aluno')},
                      text: 'Sou Aluno'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*--------------------------------------------------------------------------*/
  Function irParaLogin(String user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(
              user: user,
              refGestor: widget.ref_gestor,
            )));
  }
}
