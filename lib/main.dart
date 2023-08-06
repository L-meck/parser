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

  String? tsrRep, filePath, csvName, csvNameD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _data != 'null' ?
          ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index){
          return Column(
            children: [
                  Card(
              margin: const EdgeInsets.all(3),
            color: index==0 ? Colors.amberAccent : Colors.white,
            child: ListTile(
              leading: Text(_data[index][0].toString()),
              subtitle: Text(_data[index][1].toString()),
              title: Text(_data[index][2].toString()),
              trailing: Text(_data[index][3].toString()),
            ),
          ) // const Text(style: TextStyle(fontWeight: FontWeight.bold),'Dev-Version: 0.0.1')
            ]
          );
        }
      ) : const Center(
        child: Text("no file selected,\nkindly pick a file",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
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
              csvNameD = csvName;
              _data = fields; //actual data
        },
      );
    }
}
