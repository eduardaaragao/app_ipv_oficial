import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

class BotaoDark extends StatelessWidget {
  const BotaoDark({
    Key key,
    @required this.text,
    @required this.press,
    this.width,
  }) : super(key: key);

  final String text;
  final press;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(left: 25, right: 25)),
        backgroundColor: MaterialStateProperty.all<Color>(Uteis.kPrimaryDarkColorTwo),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            )
        ),
      ),
      onPressed: press,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: Uteis.kWhite),
      ),
    );
  }
}
