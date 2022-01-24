import 'dart:convert';
import 'package:app_ipv/Classes/Dados.dart';
import 'package:app_ipv/Classes/Professor.dart';
import 'package:app_ipv/Design/Widgets/CardAulaWidget.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

class HomeProfessor extends StatefulWidget {
  final Professor professor;
  final Gestao ref_gestor;

  const HomeProfessor({Key key,
    @required this.professor,
    @required this.ref_gestor}) : super(key: key);

  @override
  _HomeProfessorState createState() => _HomeProfessorState();
}

class _HomeProfessorState extends State<HomeProfessor> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(
              'Bem vindo (a), ' + widget.professor.nome + '.',
              style: Uteis.kParagraphStyle,
            ),
            Text(
              "Home",
              style: Uteis.kHeaderStyle.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
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
                  return Container(
                    padding: const EdgeInsets.only(left: 23),
                    height: 160,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          return CardAulaWidget(
                              idUsuario: widget.professor.id,
                              aula: snapshot.data[index],
                              acessoProfessor: true,
                              ref_gestor: widget.ref_gestor
                          );
                        }),
                  );
                }else if (snapshot.hasError){
                  return const Text('Hoje não há aulas');
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              }
          ),
        ],
      ),
    );
  }

  // Função para obter as aulas do professor -----------------------------------
  Future <List> getAulas() async{
    DateTime now =  DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String data = "${date.year}-${date.month}-${date.day}";

    var resultado = await widget.ref_gestor.getAulas("professor", widget.professor.id, data);

    List dados = jsonDecode(resultado);

    listaAulas = dados;

    return listaAulas;
  }
}