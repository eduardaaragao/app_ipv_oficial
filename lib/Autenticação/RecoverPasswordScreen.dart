import 'package:app_ipv/Design/Bot%C3%B5es/BotaoDark.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecoverPasswordScreen extends StatefulWidget {
  @override
  _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  bool _isEmailValid = false;
  final _emailKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 36, top: 30),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Uteis.kPrimaryDarkColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 39, top: 30, right: 39),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recuperar Password',
                style: Uteis.kHeaderStyle,
              ),
              SizedBox(height: 30),
              Center(child: SvgPicture.asset(Uteis.kRecoverPassPhoto)),
              SizedBox(height: 26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Esqueceu sua password?', style: Uteis.kHeadlineStyle),
                  Text('Enviaremos um e-mail de confirmação'),
                  Form(
                    key: _formKey,
                    child: campoEmail(),
                  ),
                  SizedBox(height: 80),
                  BotaoDark(
                    text: 'Enviar',
                    press: onPress,
                    width: 320,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Validar o Email----------------------------------------------- */
  String validarEmail(String value) {
    if (value == null || value.isEmpty) return 'Este campo não pode ser vazio';
    Pattern padrao =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(padrao);
    if (!regex.hasMatch(value)) return 'Por favor, digite um email válido';
    return null;
  }

  /*Passar para a página seguinte -------------------------------- */
  Future onPress() async {
    bool validacao = await (_formKey.currentState.validate());
    if (validacao) {
      print("Validado");
    } else {
      print("Não validado");
    }
    print("EMAIL: " + _email);
  }

  TextFormField campoEmail() {
    return TextFormField(
      key: _emailKey,
      onChanged: (val) {
        _email = val;
        final isValid = _emailKey.currentState.validate();
        if (_isEmailValid != isValid) {
          setState(() {
            _isEmailValid = isValid;
          });
        }
      },
      validator: validarEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: Uteis.kDefaultInputDecoration.copyWith(
          labelText: 'E-mail',
          suffixIcon: _isEmailValid
              ? Icon(
            Icons.check,
            color: Colors.green,
          )
              : null),
    );
  }
}
