class Professor{
  final String id;
  final String nome;

  Professor(
      this.id,
      this.nome);

  factory Professor.fromJson(Map <dynamic, dynamic> json){
    return Professor(
      json["ID"],
      json["NOME"],
    );
  }

  Map<dynamic, dynamic> toJson() => {
    'ID': id,
    'NOME': nome,
  };
}