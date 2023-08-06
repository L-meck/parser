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
      home: MyHomePage(title: 'e/csv parser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> _data = [];
  String? _tsrName;
  String? _fileName;
  String? filePath;
  String? checky;
  // String selectedItem = 'TSR';
  dynamic currentStep = 0;
  List<List<dynamic>> tsr2 = [];
  String? tsrRep;

  String? linl;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(style: TextStyle(fontWeight: FontWeight.bold),'Version: 0.0.1'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Upload',
        child: const Icon(Icons.upload),
      ),
    );
  }
    void _pickFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['csv'],
      );

      // if no file is picked
      if (result == null) return;
      //
      // we will log the name, size and path of the
      // first picked file (if multiple are selected)
      //
      // debugPrint('Niko hapa: ${result.files.first.name}'); //name of csv

      checky = result.files.first.name; //name of csv
      filePath = result.files.first.path!;

      final input = File(filePath!).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      // debugPrint('Niko Pale: $fields'); //actual data
      // debugPrint('checky $checky'); //name of csv

      tsrRep = fields[4].toSet().toString();
      // debugPrint('please work $tsrRep');

      setState(
            () {
          _fileName = checky; //file name
          _data = fields; //actual data
          tsr2 = tsr2; //TODO: fix remove repeated tsr names
        },
      );
    }
}
