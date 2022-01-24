import 'dart:convert';
import 'package:app_ipv/Classes/Aluno.dart';
import 'package:app_ipv/Classes/Dados.dart';
import 'package:app_ipv/Classes/Disciplinas.dart';
import 'package:app_ipv/Classes/Professor.dart';
import 'package:app_ipv/Design/Bot%C3%B5es/BotaoDark.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:app_ipv/Professor/NavBarProfessor.dart';
import 'package:app_ipv/Student/NavBarStudent.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'RecoverPasswordScreen.dart';

/*--------------------------- Login Screen ---------------------------*/
class LoginScreen extends StatefulWidget {
  final String user;
  final Gestao refGestor;

  LoginScreen({this.user, this.refGestor});

  @override
  _LoginScreenState createState() => _LoginScreenState(this.user);
}

class _LoginScreenState extends State<LoginScreen> {
  String typeLoginRef;
  bool loading = false;
  bool _isPassValid = false;
  String _email = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  _LoginScreenState(String user) {
    typeLoginRef = user;
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreenWidget();
  }

  /*--------------------------------------------------------------------------*/
  Widget LoginScreenWidget(){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 36, top: 30),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Uteis.kPrimaryDarkColorTwo,

          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LoginScreenBody(),
    );
  }
  /*--------------------------------------------------------------------------*/


  /*--------------------------------------------------------------------------*/
  Widget LoginScreenBody(){
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 35, right: 35),
        alignment: Alignment.topLeft,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login de ${typeLoginRef}',
                  style: Uteis.kHeaderStyle,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Insira suas credenciais da instituição para iniciar.',
                  style: Uteis.kDescriptionStyle,
                ),
              ],
            ),Image(image: AssetImage(typeLoginRef == 'Professor' ?
            Uteis.kProfessorPhoto :
            Uteis.kStudentPhoto)),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  emailField(),
                  passwordField(),
                  forgotPassword(),
                ],
              ),
            ),
            loading ? LinearProgressIndicator(backgroundColor: Uteis.kPrimaryColor, color: Uteis.kPrimaryDarkColorTwo) :
            BotaoDark(
                press: typeLoginRef == 'Professor'
                    ? onLoginProfessor
                    : onLoginAluno,
                text: 'Login',
                width: 320),
          ],
        ),
      ),
    );
  }


  /*------------------------------------------------------------------------- */
  String checkPassword(String value) {
    return value.isEmpty ?  'Por favor, digite sua password' : null;
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  String checkEmail(String value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite um utilizador válido.';
    }
    return null;
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  TextFormField emailField() {
    return TextFormField(
      validator: checkEmail,
      onChanged: (val) {
        setState(() {
          _email = val;
        });
      },
      keyboardType: TextInputType.emailAddress,
      decoration: Uteis.kDefaultInputDecoration.copyWith(
        labelText: 'E-mail',
      ),
    );
  }
  /*--------------------------------------------------------------------------*/

  /*------------------------------------------------------------------------- */
  TextFormField passwordField() {
    return TextFormField(
      key: _passKey,
      onChanged: (val) {
        setState(() {
          _password = val;
        });
        final isValid = _passKey.currentState.validate();
        if (_isPassValid != isValid) {
          setState(() {
            _isPassValid = isValid;
          });
        }
      },
      validator: checkPassword,
      obscureText: true,
      decoration: Uteis.kDefaultInputDecoration.copyWith(
          labelText: 'Password',
          suffixIcon:
          _isPassValid ? const Icon(Icons.check, color: Colors.green) : null),
    );
  }
  /*--------------------------------------------------------------------------*/

  /*------------------------------------------------------------------------- */
  GestureDetector forgotPassword() {
    return GestureDetector(
        onTap: recoverPassword,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('Esqueci a senha',
                style: TextStyle(decoration: TextDecoration.underline)),
          ],
        ));
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Future<String> login() async {
    String passConvertida = generateMD5(_password);
    final String resultado = await widget.refGestor
        .fazerLoginUser(_email, passConvertida, typeLoginRef);

    return resultado;
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Aluno storeDataAluno(String dados)
  {
    final Map<String, dynamic> data = jsonDecode(dados);

    Aluno aluno = Aluno.fromJson(data["DADOS"]);

    return aluno;
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Future<bool> onLoginAluno() async {
    setState(() {
      loading = true;
    });

    final String resultado = await login();

    if (resultado!= null && resultado.contains("true")){
      Aluno aluno = storeDataAluno(resultado);
      goHomeAluno(aluno);
    }else{
      Uteis.mostrarMensagem(context, "Password ou e-mail inválidos", "TENTAR NOVAMENTE");
    }
    setState(() {
      loading = false;
    });
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Professor storeDataProfessor(String dados)
  {
    final Map<String, dynamic> data = jsonDecode(dados);

    Professor professor = Professor.fromJson(data["DADOS"]);

    if (data["DADOS"]["DISCIPLINAS"] != 'NADA_ENCONTRADO')
    {
      data["DADOS"]["DISCIPLINAS"].forEach((e) {
        Disciplina disciplina = Disciplina.fromJson(e);
        disciplinas.add(disciplina);
      });
    }

    return professor;
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Future<bool> onLoginProfessor() async {
    setState(() {
      loading = true;
    });

    if (_formKey.currentState.validate())
    {
      String resultado = await login();

      if (resultado!= null && resultado.contains("true")) {
        Professor dados = storeDataProfessor(resultado);
        goHomeProfessor(dados);
      }else {
        Uteis.mostrarMensagem(context, "Password ou e-mail inválidos", "TENTAR NOVAMENTE");
      }
    }

    setState(() {
      loading = false;
    });
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Function goHomeProfessor(Professor dados) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NavBarProfessor(
            refGestor: widget.refGestor,
            professor: dados,
          ),
        ),
            (route) => false);
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Function recoverPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RecoverPasswordScreen()));
  }
  /*--------------------------------------------------------------------------*/


  /*------------------------------------------------------------------------- */
  Function goHomeAluno(Aluno data) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NavBarStudent(
              ref_gestor: widget.refGestor,
              dataAluno: data,
            )),
            (route) => false);
  }
}
/*--------------------------------------------------------------------------*/


/*------------------------------------------------------------------------- */
String generateMD5(String pass) {
  return md5.convert(utf8.encode(pass)).toString();
}
