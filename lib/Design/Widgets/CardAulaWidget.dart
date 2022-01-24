import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

import 'InfoAulaScreen.dart';

class CardAulaWidget extends StatelessWidget {
  final String idUsuario;
  final Map aula;
  bool acessoProfessor;
  final Gestao ref_gestor;

  CardAulaWidget({
    Key key,
    @required this.aula,
    @required this.acessoProfessor,
    @required this.ref_gestor,
    @required this.idUsuario,
  });

  @override
  Widget build(BuildContext context) {
    void onTap() { Navigator.push(context,
        MaterialPageRoute(builder: (context) => InfoAula(
          ref_gestor: ref_gestor,
          aula: aula,
          professor: acessoProfessor,
          id: idUsuario,
        )));
    }

    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.only(right: 15.0),
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Uteis.kPrimaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                aula["ESTADO"] == '1' ? _labelWidget() : Text(""),
                Text(aula["NOME"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Uteis.kPrimaryDarkColorTwo)),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.place, size: 13,
                            color: Uteis.kDescriptionColor),
                        Text(
                          aula["LOCAL"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Uteis.kDescriptionColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 13,
                            color: Uteis.kDescriptionColor),
                        Text(
                          aula["HORA_INICIO"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Uteis.kDescriptionColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Stack _labelWidget(){
    return Stack(
      children: [
        Positioned(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ) // green shaped
            ),
            child: Text("A DECORRER", style: TextStyle(color: Uteis.kWhite, fontSize: 10)),
          ),
        ),],
    );
  }
}
