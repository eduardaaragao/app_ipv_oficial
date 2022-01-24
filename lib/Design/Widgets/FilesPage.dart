import 'package:app_ipv/Gestao/Uteis.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilesPage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const FilesPage({
    Key key,
    @required this.files,
    @required this.onOpenedFile}) : super(key: key);

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Uteis.kPrimaryDarkColor,
      title: const Text('Todos os ficheiros'),
      centerTitle: true,
    ),
    body: Center(
      child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: widget.files.length,
          itemBuilder: (context, index){
            final file = widget.files[index];
            return buildFile(file);
          }),
    ),
  );

  Color getColor (String extension)
  {
    if (extension == 'pdf') {
      return const Color.fromRGBO(245,156,30,1);
    }

    if (extension == 'docx') {
      return Uteis.kPrimaryDarkColor;
    }

    return const Color.fromRGBO(120,82,169,1);
  }

  Widget buildFile(PlatformFile file){
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize = mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : kb.toStringAsFixed(2);
    final extension = file.extension ?? 'nenhuma';
    final color = getColor(extension);

    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Text(
                  '.$extension',
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              file.name.length > 40 ?  file.name.substring(0, 10) + '...' : file.name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
                fileSize,
                style: const TextStyle(fontSize: 16)
            )
          ],
        ),
      ),
    );
  }

}
