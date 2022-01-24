class Disciplina{
  String disciplina;
  String codigo;

  Disciplina(
      this.codigo,
      this.disciplina);

  factory Disciplina.fromJson(Map <dynamic, dynamic> json){
    return Disciplina(
      json["CODIGO"],
      json["DISCIPLINA"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
    'CODIGO': codigo,
    'DISCIPLINA': disciplina,
  };
}