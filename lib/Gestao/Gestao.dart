import 'package:http/http.dart' as HTTP;
import 'package:http/http.dart';

class Carta {
  Map<String, String> Dados;

  Carta() {
    Dados = Map<String, String>();
  }

  //--------------------------------------

  void Add(String key, String valor) {
    Dados[key] = valor;
  }

  //---------------------------------------

  String Get(String key) {
    if (Dados.containsKey(key)) return Dados[key];
    return null;
  }

  //--------------------------------------

  Map<String, String> GetDados() {
    return Dados;
  }

  //--------------------------------------

  Iterable<String> GetKeys() {
    return Dados.keys;
  }

  //--------------------------------------

  void Mostrar() {
    Iterable<String> listaKeys = GetKeys();
    if (listaKeys != null && listaKeys.isNotEmpty) {
      for (String key in listaKeys) {
        print('Dados [' + key + ']' + Dados[key]);
      }
    }
  }
}

/*--------------------------------------------------------------------------*/

class Gestao {
  String _path_servidor;
  String _path_servidor_servico;

  /*--------------------------------------------------------------------------*/
  Gestao(String pathServ, String servico) {
    _path_servidor = pathServ;
    _path_servidor_servico = pathServ + servico;
  }

  /*--------------------------------------------------------------------------*/
  String getPathServidor() {
    return _path_servidor;
  }

  /*--------------------------------------------------------------------------*/
  Future<String> executarServidor(Carta C) async {
    String respostaServidor;
    Client servidor = HTTP.Client();
    try {
      C.Add('FONTE', 'APP');
      C.Add('TOKEN', '12345');

      var response = await servidor.post(Uri.parse(_path_servidor_servico),
          body: C.GetDados());
      if (response.statusCode == 200) {
        respostaServidor = response.body;
      } else {
        print('Resposta do servidor INVÁLIDA!');
      }
    } finally {
      servidor.close();
    }

    return respostaServidor;
  }

  /*--------------------------------------------------------------------------*/
  Future<String> marcarPresencaAluno(String aula, String aluno) async{
    Carta carta = Carta();

    carta.Add("ACCAO", "MARCAR_PRESENCA");
    carta.Add("ID_ALUNO", aluno);
    carta.Add("ID_AULA", aula);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/
  Future<String> getPresencas(String aula) async{
    Carta carta = Carta();

    carta.Add("ACCAO", "GET_PRESENCAS");
    carta.Add("ID_AULA", aula);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/
  Future<String> avaliarProfessor(String id, String valor) async{
    Carta carta = Carta();
    carta.Add("ACCAO", "AVALIAR_AULA");
    carta.Add("ID_AULA", id);
    carta.Add("VALOR", valor);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/
  Future<String> encerrarAulaProfessor(String id) async{
    Carta carta = Carta();
    carta.Add("ACCAO", "TERMINAR_AULA");
    carta.Add("ID_AULA", id);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/
  Future <String> getTurnos(String professor, String disciplina) async {
    Carta carta = Carta();
    carta.Add("ACCAO", "GET_TURNOS");
    carta.Add("ID_PROFESSOR", professor);
    carta.Add("CODIGO_DISCIPLINA", disciplina);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  Future <String> iniciarAula(String id) async {
    Carta carta = Carta();
    carta.Add("ACCAO", "INICIAR_AULA");
    carta.Add("ID_AULA", id);

    var resultado = await executarServidor(carta);

    return resultado;
  }

  /*--------------------------------------------------------------------------*/
  Future <String> sendNotification(String professor, List turno, String mensagem) async {
    Carta carta = Carta();
    carta.Add("ACCAO", "CRIAR_NOTIFICACAO");
    carta.Add("ID_PROFESSOR", professor);
    carta.Add("ID_TURNO", turno.join(',').toString());
    carta.Add("MSG", mensagem);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/
  Future<String> getAllNotificacoes(String professor) async {
    Carta carta = Carta();
    carta.Add("ACCAO", "GET_ALL_NOTIFICACOES");
    carta.Add("ID_PROFESSOR", professor);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/
  Future <String> getAulas(String user, String id, String data) async {
    Carta carta = Carta();
    carta.Add("ACCAO", "GET_AULAS_" + user.toUpperCase());
    carta.Add("ID_" + user.toUpperCase(), id);
    carta.Add("DATA", data);

    String resposta = await executarServidor(carta);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/

  Future<String> fazerLoginUser(String email, String pass, String user) async {
    String resposta;
    resposta = await getLogin(email, pass, user);

    return resposta;
  }

  /*--------------------------------------------------------------------------*/

  Future<String> getLogin(String email, String pass, String user) async {
    Carta carta = Carta();
    carta.Add("ACCAO", "LOGIN_" + user.toUpperCase());
    carta.Add("EMAIL", email);
    carta.Add("SENHA", pass);

    String resposta = await executarServidor(carta);

    return resposta;
  }
}
