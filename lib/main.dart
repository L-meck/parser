import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'csv parser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'e/csv parser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> _data = [];
  List<List<dynamic>> tsr2 = [];

  String? filePath;
  String? csvName;
  String? tsrRep;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(style: TextStyle(fontWeight: FontWeight.bold),'Dev-Version: 0.0.1'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFile,
        tooltip: 'Upload',
        child: const Icon(Icons.upload),
      ),
    );
  }
    void _pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['csv'],
      );

      // if (result != null) {
      //   File file = File(result.files.first.path);
      // } else {
      //   // User canceled the picker
      // }

      if (result == null) return;
      csvName = result.files.first.name; //name of csv
      filePath = result.files.first.path!;

      final input = File(filePath!).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      tsrRep = fields[4].toSet().toString();
      debugPrint('$csvName');
      setState(
            () {
          _data = fields; //actual data
        },
      );
    }
}
