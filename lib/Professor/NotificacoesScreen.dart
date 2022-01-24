import 'dart:convert';
import 'package:app_ipv/Classes/Dados.dart';
import 'package:app_ipv/Classes/Professor.dart';
import 'package:app_ipv/Design/Bot%C3%B5es/BotaoLight.dart';
import 'package:app_ipv/Design/Widgets/NotificationWidget.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';

import 'AddNotificacaoScreen.dart';

class NotificacoesScreen extends StatefulWidget {
  final Professor professor;
  final Gestao ref_gestor;

  const NotificacoesScreen({Key key,
    @required this.professor,
    @required this.ref_gestor}) : super(key: key);
  @override
  _NotificacoesScreenState createState() => _NotificacoesScreenState();
}

class _NotificacoesScreenState extends State<NotificacoesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Uteis.kWhite,
      body: Center(
          child: FutureBuilder(
            future: getAllNotificacoes(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: [
                        NotificacaoWidget(
                          descricao: snapshot.data[index]["NOTIFICACAO"]["DESCRICAO"],
                          disciplina: snapshot.data[index]["NOTIFICACAO"]["DISCIPLINA"],
                        ),
                      ],
                    );
                  },
                );
              }else{
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/imgs/no_results.png",
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.15,
                      left: MediaQuery.of(context).size.width * 0.065,
                      right: MediaQuery.of(context).size.width * 0.065,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 13),
                              blurRadius: 25,
                              color: const Color(0xFF5666C2).withOpacity(0.17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          )
      ),
      floatingActionButton: BotaoLight(text: 'adicionar notificação', press: addNotificacao),
    );
  }

  /* Ir para a tela de Adicionar Notificação -------------------------------- */
  void addNotificacao() {
    if (disciplinas == null || disciplinas.isEmpty){
      Uteis.mostrarMensagem(context, "Você ainda não tem nenhuma disciplina associada", "OK");
    }else{
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddNotificacao(
            professor: widget.professor,
            ref_gestor: widget.ref_gestor,)));
    }
  }

  /* Obter todas as notificações publicadas pelo professor------------------- */
  Future<List> getAllNotificacoes() async{
    final String resultado = await widget.ref_gestor.getAllNotificacoes(widget.professor.id);

    return (jsonDecode(resultado));
  }
}
