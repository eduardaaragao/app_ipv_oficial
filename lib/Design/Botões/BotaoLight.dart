import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

class BotaoLight extends StatelessWidget {
  const BotaoLight({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(left: 25, right: 25)),
        backgroundColor: MaterialStateProperty.all<Color>(Uteis.kWhite),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            )
        ),
      ),
      onPressed: press,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: Uteis.kPrimaryDarkColorTwo),
      ),
    );
  }
}