import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async{
  String path = (await getExternalStorageDirectory()).path;
  String filePath = '$path/$fileName';
  final file = File(filePath);

  await file.writeAsBytes(bytes, flush: true);

//  OpenFile.open(filePath);
}