class Turno{
  final String id;
  final String turno;

  Turno(
      this.id,
      this.turno);

  factory Turno.fromJson(Map<String, dynamic> json) => Turno(
    json["ID"],
    json["TURNO"],
  );
}