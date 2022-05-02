import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class Pdfapi2 {

 static Future<void> demo() async {

  final pdf = pw.Document();

  pdf.addPage(
  pw.Page(
  build: (pw.Context context) => pw.Center(
  child: pw.Text('Hello World!'),
  ),
  ),
  );

  final bytes = await pdf.save();
  // final file = File('example.pdf');
  // await file.writeAsBytes(await pdf.save());
  final dir = await getApplicationDocumentsDirectory();
  final file=await File('${dir.path}/"Hello.pdf');
  // final file =File('${dir.path}/$name');
  await file.writeAsBytes(bytes);
  final url = file.path;
  print(file.path);
  await OpenFile.open(url);
  print("Open");
}
}

