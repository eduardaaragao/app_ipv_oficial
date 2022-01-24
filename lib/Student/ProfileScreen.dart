import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.all(20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Uteis.kPrimaryColor,
        appBar: AppBar(),
        body: Column(
          children: [
            /*Extrair para stateless class depois*/
            Center(
              child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/imgs/imagem.png"),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              flatButtonStyle: flatButtonStyle,
              text: 'estgv18545@alunos.estgv.ipv.pt',
              icone: const Icon(Icons.email),
            ),
            ProfileMenu(
              flatButtonStyle: flatButtonStyle,
              text: 'Maria Eduarda Aragão',
              icone: const Icon(Icons.person),
            ),
            ProfileMenu(
              flatButtonStyle: flatButtonStyle,
              text: 'Engenharia Informática',
              icone: const Icon(Icons.computer),
            ),
            ProfileMenu(
              flatButtonStyle: flatButtonStyle,
              text: 'Finalizar Sessão',
              icone: const Icon(Icons.logout),
              press: () {
                if (kDebugMode) {
                  print("Logging out");
                }
              },
            ),
            /* Extrair para stateless class depois*/
          ],
        ));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.flatButtonStyle,
    @required this.text,
    @required this.icone,
    this.press,
  }) : super(key: key);

  final ButtonStyle flatButtonStyle;
  final String text;
  final Icon icone;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: press,
        style: flatButtonStyle,
        child: Row(
          children: [
            icone,
            SizedBox(width: 20),
            Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
    );
  }
}
