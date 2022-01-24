import 'package:flutter/material.dart';

class Uteis {
  static Color kPrimaryColor = const Color.fromRGBO(246, 249, 254, 1.0);

  static Color kPrimaryButtonColor =  const Color.fromRGBO(76,148,233,1.0);

  static Color kPrimaryDarkColorTwo = const Color.fromRGBO(33,47,106, 1.0);

  static Color kWhite = Colors.white;

  static Color kPrimaryDarkColor = const Color.fromRGBO(106,130,245,1.0);

  static Color kDividerColor = const Color.fromRGBO(234, 239, 245, 1);

  static Color kDarkModePrimaryColor = const Color.fromRGBO(34, 30, 34, 1.0);

  static Color kDarkModeYellow = const Color.fromRGBO(236, 167, 44, 1.0);

  static Color kDescriptionColor = const Color.fromRGBO(108,123,160,1.0);

  static Color kShadowColor = const Color(0xFFB7B7B7).withOpacity(.16);

  static String kSplashPhoto = 'assets/imgs/foto_1.svg';

  static String kProfessorPhoto = 'assets/imgs/foto_2.png';

  static String kStudentPhoto = 'assets/imgs/foto_aluno.png';

  static String kRecoverPassPhoto = 'assets/imgs/recover_pass.svg';

  static TextStyle kHeaderStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: kPrimaryDarkColorTwo,
  );

  static TextStyle kParagraphStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: kDescriptionColor,
  );

  static TextStyle kTitleAulaStyle = TextStyle(
    fontSize: 16,
    color: kDescriptionColor,
  );

  static TextStyle kHeadlineStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: kPrimaryDarkColorTwo,
  );

  static TextStyle kDescriptionStyle =
  TextStyle(fontSize: 15, color: kDescriptionColor);

  static InputDecoration kDefaultInputDecoration = InputDecoration(
      labelStyle: TextStyle(fontSize: 15, color: kPrimaryDarkColorTwo),
      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryDarkColorTwo)
      )
  );

  static double paddingSize = 30.0;

  /*------------------------------------------------------------------------- */
  static void mostrarMensagem(BuildContext context, String mensagem, String label) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      action: SnackBarAction(
          label: label,
          onPressed: () {
            print("a tentar novamente");
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
