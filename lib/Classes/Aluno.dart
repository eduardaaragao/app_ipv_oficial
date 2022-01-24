class Aluno{
  final String id;
  final String nome;
  final String curso;

  Aluno(
      this.id,
      this.nome,
      this.curso
      );

  factory Aluno.fromJson(Map <dynamic, dynamic> json){
    return Aluno(
      json["ID"],
      json["NOME"],
      json["CURSO"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
    'ID': id,
    'NOME': nome,
    'CURSO': curso,
  };
}