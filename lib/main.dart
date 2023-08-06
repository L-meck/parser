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
  List<List<dynamic>> data = [];
  List<List<dynamic>> tsr2 = [];


  String? tsr, filePath, csvName, csvNameD, tsrName;

  // Set<List<dynamic>>  uniqueItems = data.toSet();
  // List<String> uniqueList = uniqueItems.toList();
  // List<String> uniqueList = uniqueItems.map((item) => item.join(', ')).toList();
  // List<List<dynamic>> uniqueItems = sett.toSet().toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body: ListView.builder(
      //   itemCount: _data.length,
      //   itemBuilder: (_, index){
      //     return Column(
      //       children: [
      //             Card(
      //         margin: const EdgeInsets.all(3),
      //       color: index==0 ? Colors.amberAccent : Colors.white,
      //       child: ListTile(
      //         leading: Text(_data[index][0].toString()),
      //         subtitle: Text(_data[index][1].toString()),
      //         title: Text(_data[index][2].toString()),
      //         trailing: Text(_data[index][3].toString()),
      //       ),
      //     ) // const Text(style: TextStyle(fontWeight: FontWeight.bold),'Dev-Version: 0.0.1')
      //       ]
      //     );
      //   }
      //       ),
      body: Column(
        children: [
        Center(
          child: DropdownButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              items: data.map((item) {
                return DropdownMenuItem(
                  value: tsr,
                  child: GestureDetector(
                    child: Text(
                      item[5].toString(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                    setState(() {
                      tsrName = item[5].toString();
                      debugPrint(tsrName);
                    });
                    Navigator.pop(context);
                  },
                  ),
                );
              }).toSet().toList(), //.toSet().toList(),
            onChanged: (String? val) {
              // setState(() {
                // tsrNamey = tsrRep.toString();
              // });
            },
          ),
        ),
        ],
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

      tsr = fields[5].toSet().toString();
      debugPrint('$csvName');
      setState(
            () {
              csvNameD = csvName;
              data = fields; //actual data
              // sett = fields;
        },
      );
    }
}
