import 'dart:convert';
import 'package:app_ipv/Classes/Aluno.dart';
import 'package:app_ipv/Classes/Dados.dart';
import 'package:app_ipv/Design/Widgets/CardAulaWidget.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

/*--------------------------- Student homepage screen ---------------------------*/
class HomeStudentScreen extends StatefulWidget {
  final Aluno aluno;
  final Gestao ref_gestor;

  const HomeStudentScreen({Key key, this.aluno, this.ref_gestor}) : super(key: key);
  @override
  _HomeStudentScreenState createState() => _HomeStudentScreenState();
}

class _HomeStudentScreenState extends State<HomeStudentScreen> {
  @override
  void initState() {
    getAulas();
  }

  @override
  Widget build(BuildContext context) {
    return HomeWidget();
  }

  /*--------------------------------------------------------------------------*/
  Widget HomeWidget(){
    return Scaffold(
      appBar: AppBarWidget(),
      body: BodyHomeWidget(),
    );
  }
  /*--------------------------------------------------------------------------*/


  /*--------------------------------------------------------------------------*/
  Widget AppBarWidget(){
    return PreferredSize(
      preferredSize: const Size.fromHeight(75.0),
      child: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(11.0),
            ),
            Text(
              'Bem vindo (a), ' + widget.aluno.nome + '.',
              style: Uteis.kParagraphStyle,
            ),
            Text(
              "Home",
              style: Uteis.kHeaderStyle,
            ),
          ],
        ),
      ),
    );
  }
  /*--------------------------------------------------------------------------*/

  /*--------------------------------------------------------------------------*/
  Widget BodyHomeWidget(){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 23, top: 30, right: 39),
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Aulas de hoje",
                style: Uteis.kHeaderStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        FutureBuilder(
            future: getAulas(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.hasData){
                return list(listaAulas);
              }else if (snapshot.hasError){
                return const Text('Hoje não há aulas');
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ],
    );
  }
  /*--------------------------------------------------------------------------*/

  /*--------------------------------------------------------------------------*/
  Container list(data)
  {
    return Container(
      padding: const EdgeInsets.only(left: 23),
      height: 160,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            return CardAulaWidget(
                idUsuario: widget.aluno.id,
                aula: data[index],
                acessoProfessor: false,
                ref_gestor: widget.ref_gestor
            );
          }),
    );
  }
  /*--------------------------------------------------------------------------*/

  /*--------------------------------------------------------------------------*/
  Future <List> getAulas() async{
    DateTime now =  DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    //String data = "${date.year}-${date.month}-${date.day}";
    String data = "2021-12-29";

    var resultado = await widget.ref_gestor.getAulas("aluno", widget.aluno.id, data);

    List resultadoDecod = jsonDecode(resultado);

    setState(() {
      listaAulas = resultadoDecod;
    });

    listaAulas = resultadoDecod;

    return listaAulas;
  }
/*--------------------------------------------------------------------------*/

}
