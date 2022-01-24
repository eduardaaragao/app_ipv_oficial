import 'dart:convert';
import 'package:app_ipv/Classes/Dados.dart';
import 'package:app_ipv/Classes/Professor.dart';
import 'package:app_ipv/Classes/Turno.dart';
import 'package:app_ipv/Design/Bot%C3%B5es/BotaoDark.dart';
import 'package:app_ipv/Design/Widgets/FilesPage.dart';
import 'package:app_ipv/Gestao/Gestao.dart';
import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class AddNotificacao extends StatefulWidget {
  final Gestao ref_gestor;
  final Professor professor;

  const AddNotificacao({Key key,
    @required this.ref_gestor,
    @required this.professor}) : super(key: key);

  @override
  _AddNotificacaoState createState() => _AddNotificacaoState();
}

class _AddNotificacaoState extends State<AddNotificacao> {
  Map <String, dynamic> turnosSelecionados = {};

  bool selected = false;
  String _descricao = '';

  String valueDisc = disciplinas[0].codigo;

  var tmpArray = [];

  var listadeturnos = [];

  @override
  void initState() {
    super.initState();
    getTurnos(valueDisc);
  }

  bool progress = false;

  // Obter os turnos que foram selecionados na caixa ---------------------------
  getCheckBoxItems(){
    for (var element in listadeturnos) {
      if (element["selecionado"] == true)
        {
          tmpArray.add(element["id"]);
        }
    }
    /*turnosSelecionados.forEach((key, value) {
      if (value==true){
        tmpArray.add(key);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Uteis.kWhite,
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      btnUpload(),
                      const SizedBox(height: 20),
                      Row(children: [Text("Mensagem", style: TextStyle(color: Uteis.kDescriptionColor))]),
                      campoDescricao(),
                      Row(children: [Text("Selecione a disciplina", style: TextStyle(color: Uteis.kDescriptionColor))]),
                      Row(children: [dropDown()]),
                      const SizedBox(height: 20),
                      Row(children: [Text("Selecione o(s) turno(s)", style: TextStyle(color: Uteis.kDescriptionColor))]),
                      listaTurnos(),
                      progress ? const LinearProgressIndicator() :
                      BotaoDark(text: 'Enviar Notificação', press: sendNotification),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /* Selecionar os turnos para que a mensagem será enviada -------------- */
  Future<void> getTurnos(String codigoDisc) async{
    listadeturnos.clear();
    turnos.clear();

    setState(() {
      listadeturnos;
    });

    final response = await widget.ref_gestor.getTurnos(widget.professor.id, codigoDisc);

    final data = jsonDecode(response);

    data.forEach((e) {
      Turno turno = Turno.fromJson(e);
      turnos.add(turno);
    });

    for (var element in turnos) {
      turnosSelecionados.addAll({element.id.toString(): false});
    }

    for (var element in turnos) {
      listadeturnos.add({'id': element.id.toString(), 'selecionado': false, 'turno': element.turno.toString()});
    }

    setState(() {
      listadeturnos;
    });
  }

  /* Lista de turnos -----------------------------------------------*/
  Container listaTurnos() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      height: MediaQuery.of(context).size.height * 0.20,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15),
          itemCount: listadeturnos.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: CheckboxListTile(
                onChanged: (value) {
                  setState(() {
                    listadeturnos[index]["selecionado"] = value;
                  });
                },
                value: listadeturnos[index]["selecionado"],
                title: Text(listadeturnos[index]["turno"]),
                checkColor: Colors.white,
                activeColor: Uteis.kPrimaryDarkColor,
              ),
              decoration: BoxDecoration(
                  color: Uteis.kPrimaryColor,
                  borderRadius: BorderRadius.circular(15)),
            );
          }),
    );
  }

  void goToNotificationScreen(){
    Navigator.pop(context);
  }

  /* Enviar a notificação--------------------------------------------*/
  Future<void> sendNotification() async{
    setState(() {
      progress = true;
    });

    getCheckBoxItems();

    var resultado = await widget.ref_gestor.sendNotification(widget.professor.id, tmpArray, _descricao);

    if (resultado.contains("OK")){
      Uteis.mostrarMensagem(context, "Notificação enviada com sucesso!", "OK");
      goToNotificationScreen();
    }else{
      Uteis.mostrarMensagem(context, "Sua notificação não foi enviada. ", "TENTAR NOVAMENTE");
    }
    setState(() {
      progress = false;
    });
    tmpArray.clear();
  }

  /* Dropdown Button das disciplinas --------------------------------*/
  DropdownButton dropDown(){
    return DropdownButton(
      icon: Icon(
          Icons.arrow_drop_down_circle,
          color: Uteis.kPrimaryDarkColor),
      dropdownColor: Uteis.kPrimaryDarkColor,
      value: valueDisc,
      items: disciplinas.map((e){
        return DropdownMenuItem(
          value: e.codigo,
          child: Text(
              e.disciplina,
              style: TextStyle(color: e.codigo == valueDisc ? Uteis.kPrimaryDarkColorTwo : Uteis.kWhite)),
        );
      }
      ).toList(),
      onChanged: (valor){
        setState(() {
          valueDisc = valor;
          getTurnos(valor);
        });
      },
    );
  }

  /* Selecionar os turnos para que a mensagem será enviada -------------- */
  Row turnosList(index){
    return Row(
        children: [
          Text(index.toString()),
        ]
    );
  }

  /* Botão de carregar ficheiro ----------------------------------------- */
  GestureDetector btnUpload(){
    return GestureDetector(
      onTap: uploadFile,
      child: Center(
        child: Column(
            children: [
              Text("Carregar ficheiro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Uteis.kDescriptionColor)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Formatos aceites: ", style: TextStyle(color: Uteis.kDescriptionColor)),
                  const Text("DOCX", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(124,174,228,1.0), backgroundColor: Color.fromRGBO(222,235,249,1.0))),
                  const SizedBox(width: 5),
                  const Text("PDF", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(225,202,134,1.0), backgroundColor: Color.fromRGBO(251,243,223,1.0))),
                  const SizedBox(width: 5),
                  const Text("ZIP", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(119,200,159,1.0), backgroundColor: Color.fromRGBO(214,243,229,1.0))),
                ],
              ),
              buildDecoration(
                Stack(
                    children: [
                      Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload, size: 80, color: Uteis.kPrimaryDarkColor),
                          Text("Selecione seu ficheiro...", style: TextStyle(color: Uteis.kDescriptionColor, fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Tamanho máximo: 50MB", style: TextStyle(color: Uteis.kDescriptionColor)),
                          const SizedBox(height: 16),
                        ],
                      ),
                      ),
                    ]
                ),
              ),
            ]
        ),
      ),
    );
  }

  // Widget de fazer upload do ficheiro ----------------------------------------
  Widget buildDecoration(Widget child){
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
          color: const Color.fromRGBO(244,250,255,1.0),
          padding: const EdgeInsets.all(10),
          child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              padding: EdgeInsets.zero,
              strokeWidth: 0.5,
              dashPattern: const [8,4],
              color: const Color.fromRGBO(148,178,201,1.0),
              child: child)),
    );
  }

  /*Função do botão CARREGAR FICHEIRO ----------------------------------- */
  Future<void> uploadFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result == null) return;
    openFiles(result.files);
  }

  /*Abrir ficheiro ---------------------------------------------------- */
  void openFiles(List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FilesPage(
        files: files,
        onOpenedFile: openFile,
      )));

  void openFile(PlatformFile file){
    OpenFile.open(file.path);
  }

  /*Campo Descrição ---------------------------------------------------- */
  TextField campoDescricao() {
    return TextField(
      onChanged: (val) {
        setState(() {
          _descricao = val;
        });
      },
      maxLines: null,
      maxLength: 300,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: "Digite uma mensagem...",
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        fillColor: Uteis.kPrimaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}