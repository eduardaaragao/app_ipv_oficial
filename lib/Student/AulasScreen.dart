import 'dart:convert';
import 'package:app_ipv/Classes/Aluno.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AulasScreen extends StatefulWidget {
  final Aluno aluno;
  final Gestao ref_gestor;

  const AulasScreen({Key key, @required this.aluno, @required this.ref_gestor}) : super(key: key);

  @override
  _AulasScreenState createState() => _AulasScreenState();
}

class _AulasScreenState extends State<AulasScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendário de Aulas',
          style: Uteis.kHeaderStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: _calendarFormat,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                leftChevronIcon: Icon(Icons.arrow_back_ios, size: 15),
                rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 15),
              ),
            ),
            Container(
                color: Uteis.kPrimaryColor,
                padding: const EdgeInsets.only(top: 27),
                height: 500,
                child: FutureBuilder(
                  future: getAulas(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if (snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return _aulasList(snapshot.data[index]);
                          });
                    }else if (snapshot.hasError){
                      return const Text('Hoje não há aulas');
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

  /*Função para obter as aulas de um aluno -----------------------------------*/
  Future <List> getAulas() async{
    String data = "${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day}";

    var resultado = await widget.ref_gestor.getAulas("aluno", widget.aluno.id, data);

    return json.decode(resultado);
  }

  Column _aulasList(Map aula) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 15,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Uteis.kPrimaryDarkColorTwo,
              ),
            ),
            const SizedBox(width: 17),
            Row(
              children: [
                Text(
                  aula["HORA_INICIO"],
                  style: Uteis.kParagraphStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(57, 52, 79, 0.4)),
                ),
              ],
            ),
          ],
        ),
        aulasCalendario(aula),
      ],
    );
  }

  /*Aulas calendário ---------------------------------------------------------*/
  Material aulasCalendario(Map data) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data["NOME"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Uteis.kPrimaryDarkColorTwo,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.place,
                            color: Uteis.kPrimaryDarkColorTwo),
                        Text(
                          data["LOCAL"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Uteis.kPrimaryDarkColorTwo,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person,
                            color: Uteis.kPrimaryDarkColorTwo),
                        Text(
                          data["PROFESSOR"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Uteis.kPrimaryDarkColorTwo,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer,
                            color: Uteis.kPrimaryDarkColorTwo),
                        Text(
                          data["DURACAO"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Uteis.kPrimaryDarkColorTwo,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      color: Uteis.kWhite,
    );
  }
}
