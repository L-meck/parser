// import 'dart:convert';
// import 'dart:io';
//
// import 'package:csv/csv.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'data.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//
//   //
//   String appName = 'QSTATS';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: appName,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: appName),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   //
//   List<List<dynamic>> _data = [];
//   String? _tsrName;
//   String? _fileName;
//   String? filePath;
//   String? checky;
//   // String selectedItem = 'TSR';
//   dynamic currentStep = 0;
//   List<List<dynamic>> tsr2 = [];
//   String? tsrRep;
//
//   String? linl;
//   //
//   // _formState() {
//   //   selectedItem = _data[4] as String;
//   // }
// /////////////////////////////////
//   int _currentStep = 0;
//
//   _stepState(int step) {
//     if (_currentStep > step) {
//       return StepState.complete;
//     } else {
//       return StepState.editing;
//     }
//   }
//
// /////////////////////
//   _steps() => [
//     Step(
//       title: const Text('Choose Excel File:'),
//       content: GestureDetector(
//         onTap: () => _pickFile(),
//         child: Container(
//           decoration: BoxDecoration(
//               color: _fileName == null ? Colors.blueGrey : Colors.green,
//               borderRadius: const BorderRadius.all(Radius.circular(5))),
//           height: 100,
//           child: Row(
//             children: [
//               _fileName == null
//                   ? Center(
//                 child: Row(
//                   children: const [
//                     Padding(
//                       padding:
//                       EdgeInsets.only(left: 20.0, right: 8.0),
//                       child: Icon(
//                         Icons.coronavirus_sharp,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'Tap to select a your file',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               )
//                   : Row(
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20.0, right: 8.0),
//                     child: Icon(
//                       Icons.data_array,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Text(
//                     _fileName.toString(),
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       state: _stepState(0),
//       isActive: _currentStep == 0,
//     ),
//     Step(
//       title: const Text('Choose your name:'),
//       content: Column(
//         children: [
//           DropdownButton(
//             icon: const Icon(Icons.keyboard_arrow_down),
//             items: _data
//                 .map((item) {
//               return DropdownMenuItem(
//                 value: tsrRep,
//                 child: GestureDetector(
//                   child: Text(
//                     item[4].toString(),
//                     style: const TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                   onTap: () {
//                     setState(() {
//                       _tsrName = item[4].toString();
//                     });
//                     Navigator.pop(context);
//                   },
//                 ),
//               );
//             })
//                 .toSet()
//                 .toList(), //.toSet().toList(),
//             onChanged: (String? val) {
//               // setState(() {
//               //   selectedItem = _tsrName.toString();
//               // });
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Container(
//               height: 100.0,
//               decoration: BoxDecoration(
//                   color: _tsrName == null ? Colors.blueGrey : Colors.green,
//                   borderRadius: const BorderRadius.all(Radius.circular(5))),
//               child: Center(
//                 child: Text(
//                   _tsrName.toString(),
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       state: _stepState(1),
//       isActive: _currentStep == 1,
//     ),
//     Step(
//       title: const Text('Check your Warnings & Stats:'),
//       content: const SizedBox(),
//       state: _stepState(2),
//     )
//   ];
// //////////////////////////////////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       // floatingActionButton: FloatingActionButton(
//       //     child: Icon(Icons.refresh),
//       //     onPressed: () async {
//       //       _pickFile();
//       //       //print(data);
//       //     }),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         centerTitle: true,
//         // title: Text(
//         //   widget.title,
//         //   style: const TextStyle(
//         //     color: Colors.black,
//         //     fontWeight: FontWeight.bold,
//         //   ),
//         // ),
//         title: RichText(
//             text: TextSpan(
//               text: 'MY',
//               style: GoogleFonts.oswald(
//                 //cardo(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//               children: [
//                 TextSpan(
//                   text: 'METRICS',
//                   style: GoogleFonts.oswald(
//                     //cardo(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//                 const TextSpan(
//                   text: '-beta',
//                   // style: GoogleFonts.aclonica( //cardo(
//                   //   color: Colors.black,
//                   //   fontWeight: FontWeight.bold,
//                   //   fontSize: 20
//                   // ),
//                 ),
//               ],
//             )),
//       ),
//       body: Column(
//         children: [
//           Stepper(
//             controlsBuilder: (BuildContext context, ControlsDetails controls) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     if (_tsrName == null || _fileName == null)
//                       ElevatedButton(
//                         onPressed: controls.onStepContinue,
//                         child: _tsrName == null &&
//                             _fileName == null &&
//                             _currentStep == 2 &&
//                             _currentStep == 1
//                             ? const Text('BACK')
//                             : const Text('NEXT'),
//                       ),
//                     //
//                     if (_currentStep != 2 &&
//                         _fileName != null &&
//                         _tsrName != null)
//                       ElevatedButton(
//                         onPressed: controls.onStepContinue,
//                         child: const Text('NEXT..'),
//                       ),
//                     //
//
//                     if (_currentStep == 2 && _tsrName != null)
//                       ElevatedButton(
//                         onPressed: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //       builder: (context) =>
//                           //           DataStats(tsrName: _tsrName)),
//                           // );
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => DataStats(
//                                 tsrName1: _tsrName,
//                                 data2: _data,
//                               )));
//                         },
//                         child: const Text('Load Stats'),
//                       ),
//                     if (_currentStep == 1 ||
//                         _fileName != null && _tsrName != null)
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         child: TextButton(
//                           onPressed: controls.onStepCancel,
//                           child: const Text(
//                             'BACK',
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             },
//             onStepTapped: (step) => setState(() => _currentStep = step),
//             onStepContinue: () {
//               setState(() {
//                 if (_currentStep < _steps().length - 1) {
//                   _currentStep += 1;
//                 } else {
//                   _currentStep = 0;
//                 }
//               });
//             },
//             onStepCancel: () {
//               setState(() {
//                 if (_currentStep > 0) {
//                   _currentStep -= 1;
//                 } else {
//                   _currentStep = 0;
//                 }
//               });
//             },
//             currentStep: _currentStep,
//             steps: _steps(),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: RichText(
//               text: const TextSpan(
//                 text: 'Dev Version: ',
//                 style: TextStyle(color: Colors.black),
//                 children: [
//                   TextSpan(
//                     text: '1.0.0',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowMultiple: false,
//       allowedExtensions: ['csv'],
//     );
//
//     // if no file is picked
//     if (result == null) return;
//     //
//     // we will log the name, size and path of the
//     // first picked file (if multiple are selected)
//     //
//     // debugPrint('Niko hapa: ${result.files.first.name}'); //name of csv
//
//     checky = result.files.first.name; //name of csv
//     filePath = result.files.first.path!;
//
//     final input = File(filePath!).openRead();
//     final fields = await input
//         .transform(utf8.decoder)
//         .transform(const CsvToListConverter())
//         .toList();
//
//     // debugPrint('Niko Pale: $fields'); //actual data
//     // debugPrint('checky $checky'); //name of csv
//
//     tsrRep = fields[4].toSet().toString();
//     // debugPrint('please work $tsrRep');
//
//     setState(
//           () {
//         _fileName = checky; //file name
//         _data = fields; //actual data
//         tsr2 = tsr2; //TODO: fix remove repeated tsr names
//       },
//     );
//   }
// }

// Text( 'FILENAME: $csvNameD', style: const TextStyle(fontWeight: FontWeight.bold)),