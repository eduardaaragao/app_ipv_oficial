import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

class PresencasWidget extends StatelessWidget {
  Map dados;

  PresencasWidget({
    Key key,
    @required this.dados}) : super(key: key);

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
              title: Text(dados["NOME"], style: TextStyle(fontWeight: FontWeight.bold, color: Uteis.kPrimaryDarkColorTwo)),
              subtitle: Text(dados["NUMERO"], style: const TextStyle(color: Color.fromRGBO(174, 189, 194, 0.9))),
              leading: const Icon(Icons.perm_contact_cal_rounded),
            )),
      ),
    );
  }
}
