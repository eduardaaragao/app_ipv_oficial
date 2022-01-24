import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

class NotificacaoWidget extends StatelessWidget {
  final String descricao;
  final String disciplina;

  const NotificacaoWidget({
    Key key,
    @required this.descricao,
    @required this.disciplina}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromRGBO(174, 189, 194, 0.5))),
            onPressed: (){},
            child: ListTile(
              title: Text(disciplina, style: TextStyle(fontWeight: FontWeight.bold, color: Uteis.kPrimaryDarkColorTwo)),
              subtitle: Text(descricao, style: TextStyle(color: Uteis.kDescriptionColor)),
              leading: const Icon(Icons.notifications),
            )),
      ),
    );
  }
}
