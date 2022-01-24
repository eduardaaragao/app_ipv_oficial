import 'package:app_ipv/Classes/Aluno.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:app_ipv/Student/HomeStudentScreen.dart';
import 'package:flutter/material.dart';

import 'AulasScreen.dart';

class NavBarStudent extends StatefulWidget {
  final Aluno dataAluno;
  final Gestao ref_gestor;

  const NavBarStudent({Key key, this.dataAluno, @required this.ref_gestor}) : super(key: key);
  @override
  _NavBarStudentState createState() => _NavBarStudentState();
}

class _NavBarStudentState extends State<NavBarStudent> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeStudentScreen(aluno: widget.dataAluno, ref_gestor: widget.ref_gestor),
      AulasScreen(aluno: widget.dataAluno, ref_gestor: widget.ref_gestor,)
    ];

    return Scaffold(
      body: (_widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items:  const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Aulas',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Uteis.kPrimaryDarkColorTwo,
        elevation: 0,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        backgroundColor: Uteis.kWhite,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
