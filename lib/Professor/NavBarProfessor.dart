import 'package:app_ipv/Classes/Professor.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:app_ipv/Professor/HomeProfessorScreen.dart';
import 'package:flutter/material.dart';

import 'NotificacoesScreen.dart';

class NavBarProfessor extends StatefulWidget {
  final Professor professor;
  final Gestao refGestor;

  const NavBarProfessor({this.professor, @required this.refGestor});

  @override
  _NavBarProfessorState createState() => _NavBarProfessorState();
}

class _NavBarProfessorState extends State<NavBarProfessor> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeProfessor(professor: widget.professor, ref_gestor: widget.refGestor),
      NotificacoesScreen(professor: widget.professor, ref_gestor: widget.refGestor),
    ];
    return Scaffold(
      body: (_widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações'
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
