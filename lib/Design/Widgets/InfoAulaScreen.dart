
import 'package:app_ipv/Design/Bot%C3%B5es/BotaoDark.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:app_ipv/Student/ScanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'PresencasWidget.dart';

class InfoAula extends StatefulWidget {
  final String id;
  final bool professor;
  final Map aula;
  final Gestao ref_gestor;

  const InfoAula({
    @required this.aula,
    @required this.professor,
    @required this.ref_gestor,
    @required this.id});
  @override
  _InfoAulaState createState() => _InfoAulaState(this.professor, this.aula);
}

class _InfoAulaState extends State<InfoAula> {
  bool acessoProfessor = false;
  String estado = '';

  List dadosFake = [
    {
      "NOME": "João Pedro",
      "NUMERO": "18524",
    },
    {
      "NOME": "Maria Eduarda Aragão",
      "NUMERO": "18545",
    },
    {
      "NOME": "Laura Aragão",
      "NUMERO": "18545",
    },
  ];

  _InfoAulaState(bool professor, Map aula) {
    acessoProfessor = professor;
    estado = aula["ESTADO"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Uteis.kPrimaryDarkColorTwo,
                )),
            title: Text(widget.aula["NOME"],
                style: TextStyle(color: Uteis.kPrimaryDarkColorTwo)),
            bottom: TabBar(
              indicatorColor: Uteis.kPrimaryDarkColorTwo,
              tabs: [
                Tab(
                  child: Text(
                    "AULA",
                    style: TextStyle(color: Uteis.kPrimaryDarkColorTwo),
                  ),
                  icon: Icon(Icons.book, color: Uteis.kPrimaryDarkColorTwo),
                ),
                Tab(
                    child: Text(
                      acessoProfessor ? "PRESENÇAS" : "AVALIAÇÃO",
                      style: TextStyle(color: Uteis.kPrimaryDarkColorTwo),
                    ),
                    icon: Icon(acessoProfessor ? Icons.list : Icons.star, color: Uteis.kPrimaryDarkColorTwo)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              bodyAula(),
              Scaffold(
                floatingActionButton: acessoProfessor ? FloatingActionButton(
                  onPressed: _createPDF,
                  child: const Icon(Icons.download),
                  backgroundColor: Uteis.kPrimaryDarkColorTwo,
                ) : null,
                body: Center(
                    child: acessoProfessor ? _listaPresencas()
                        : BotaoDark(press: avaliarAula, text: "Avaliar a aula",)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*-------------------------- TAB AULA - PROFESSOR --------------------------*/

  Container _listaPresencas(){
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: getPresencas(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index){
                return PresencasWidget(dados: snapshot.data[index]);
              },
            );
          }else if(snapshot.hasError){
            return Center(child: const CircularProgressIndicator());
          }else{
            return const Text('As presenças ainda não foram contabilizadas para esta aula.', textAlign: TextAlign.center);
          }
        },
      ),
    );
  }

  /*ENCERRAR AULA DO PROFESSOR -----------------------------------------------*/
  Future<void> _encerrarAula() async{
    await widget.ref_gestor.encerrarAulaProfessor(widget.aula["ID"]);

    setState(() {
      estado = '2';
    });

    Uteis.mostrarMensagem(context, "Aula encerrada!", "OK");
    goHomeProfessor();
  }

  /*INICIAR AULA DO PROFESSOR -----------------------------------------------*/
  void _iniciarAula() async {
    var resultado = await widget.ref_gestor.iniciarAula(widget.aula["ID"]);

    if (resultado.contains("OK")){
      setState(() {
        estado = '1';
      });
      Uteis.mostrarMensagem(context, "Aula iniciada!", "OK");
    }
  }

  /*IR PARA A PÁGINA HOME ----------------------------------------------------*/
  Function goHomeProfessor() {
    Navigator.pop(context);
  }

  /*EXPORTAR PDF -------------------------------------------------------------*/
  Future<void> _createPDF() async{
    DateTime now =  DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String data = "${date.day}-${date.month}-${date.year}";

    //await Permission.storage.request();

    /*if (await Permission.storage.isGranted)
    {
      PdfDocument document = PdfDocument();

      document.pages.add();

      List<int> bytes = document.save();
      document.dispose();

      saveAndLaunchFile(bytes, 'Presencas.pdf');
    }*/
  }
  /*--------------------------------------------------------------------------*/

  /*-------------------------------- WIDGETS --------------------------------*/
  /*ITEM ---------------------------------------------------------------------*/
  rowItem(String label, IconData icone, String texto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
          child: Text(
            label,
            style: Uteis.kTitleAulaStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            children: [
              icone != null
                  ? Icon(icone, size: 15, color: Uteis.kPrimaryDarkColorTwo)
                  : const SizedBox(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  texto,
                  style: Uteis.kDescriptionStyle
                      .copyWith(color: const Color.fromRGBO(57, 52, 79, 0.69)),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Divider(
                  color: Uteis.kDividerColor,
                  thickness: 1,
                ))
          ],
        ),
      ],
    );
  }

  /*REDIRECIONAR À PÁGINA DE CONFIRMAÇÃO--------------------------------------*/
  Function goToScanPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ScanScreen(),
        ));
  }

  /*OBTER A LISTA DE PRESENÇAS------------------------------------------------*/
  Future getPresencas() async{
    /*final String resultado = await widget.ref_gestor.getPresencas(widget.aula["ID"]);

    if(resultado.contains("NADA_ENCONTRADO")){
      return null;
    }else{
      return jsonDecode(resultado);
    }*/

    return dadosFake;
  }
  /*--------------------------------------------------------------------------*/

  /*-------------------------- TAB AULA - ALUNO --------------------------*/
  /*MARCAR PRESENÇA DO ALUNO -------------------------------------------------*/
  Future _marcarPresenca() async {
    var resultado = await widget.ref_gestor.marcarPresencaAluno(widget.aula["ID"], widget.id);
  }

  /*ENVIAR AVALIAÇÃO --------------------------------------------------------*/
  Future <void> sendAvaliacao(int avaliacao) async{
    final resultado = await widget.ref_gestor.avaliarProfessor(widget.aula["ID"], avaliacao.toString());

    if (resultado.contains("OK")){
      Uteis.mostrarMensagem(context, "Aula avaliada com $avaliacao estrelas!", "FIXE!");
      Navigator.pop(context);
    }else{
      Uteis.mostrarMensagem(context, "Erro ao avaliar a aula", "OK");
    }
  }

  /*AVALIAR AULA -------------------------------------------------------------*/
  Future<void> avaliarAula() {
    var ratingValue = 0.0;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Avalie esta aula'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Não se preocupe, esta avaliação é anónima.'),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratingValue = rating;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Avaliar'),
              onPressed: () {
                Navigator.of(context).pop();
                sendAvaliacao(ratingValue.toInt());
              },
            ),
          ],
        );
      },
    );
  }

  /*FAZER SCAN DO QRCODE------------------------------------------------------*/
  Future _scanear() async {
    _marcarPresenca();
    goToScanPage();
    /*await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      Uteis.mostrarMensagem(context, "Ocorreu um erro", "OK");
    } else {
    }*/
  }
  /*--------------------------------------------------------------------------*/
  Container bodyAula() {
    return Container(
      color: Uteis.kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowItem(
            "HORÁRIO",
            Icons.timer,
            widget.aula["HORA_INICIO"] +
                ' - ' +
                widget.aula["HORA_FIM"] +
                ' • ' +
                widget.aula["DURACAO"]  +
                ' • Turno ' +
                widget.aula["TURNO"],
          ),
          rowItem("LOCAL", Icons.place, widget.aula["LOCAL"]),
          acessoProfessor ? rowItem("INÍCIO", Icons.person, widget.aula["HORA_INICIO"]) : rowItem("PROFESSOR", Icons.person, widget.aula["PROFESSOR"]) ,
          rowItem("INFORMAÇÃO DA AULA", null, widget.aula["DESCRICAO"].length > 0 ? widget.aula["DESCRICAO"] : 'Não foi adicionada informação sobre esta aula.'),
          Center(
            child: BotaoDark(
              text: acessoProfessor ? estado == '1' ? 'Encerrar Aula': 'Iniciar Aula' : 'Entrar na aula',
              width: 301,
              press: () {
                acessoProfessor ? estado == '1' ? _encerrarAula(): _iniciarAula(): _scanear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
