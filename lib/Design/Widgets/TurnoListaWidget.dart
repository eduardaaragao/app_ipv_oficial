import 'package:app_ipv/Classes/Turno.dart';
import 'package:flutter/material.dart';

class TurnoListaWidget extends StatelessWidget {
  final isSelected;
  final Turno turno;
  final ValueChanged onSelectedTurno;

  const TurnoListaWidget({
    Key key,
    @required this.isSelected,
    @required this.turno,
    @required this.onSelectedTurno}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isSelected,
        onChanged: onSelectedTurno);
  }
}
