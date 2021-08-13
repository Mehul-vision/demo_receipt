// import 'dart:io';
// import 'dart:typed_data';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/material.dart';
// import 'package:screenshot/screenshot.dart';

// class ScreenshotDemo extends StatefulWidget {
//   ScreenshotDemo({Key key}) : super(key: key);

//   @override
//   _ScreenshotDemoState createState() => _ScreenshotDemoState();
// }

// class _ScreenshotDemoState extends State<ScreenshotDemo> {
//   //Create an instance of ScreenshotController
//   ScreenshotController screenshotController = ScreenshotController();

//   @override
//   void initState() {
//     // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       backgroundColor: Colors.amber,
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text("widget.title"),
//       ),
//       body: ListView(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         children: [
//           Screenshot(
//             controller: screenshotController,
//             child: Column(
//               children: [
//                 Text("Invoice"),
//                 Container(
//                   height: 5,
//                   width: double.infinity,
//                   color: Colors.black,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Product"),
//                     Text("Quantity"),
//                     Text("Price"),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 ...List.generate(
//                   8,
//                   (index) => Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Image.network(
//                           'https://picsum.photos/250?image=9',
//                           height: 80,
//                         ),
//                         Text(index.toString()),
//                         Text("1500"),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           ElevatedButton(
//             child: Text(
//               'Capture Above Widget',
//             ),
//             onPressed: () {
//               screenshotController
//                   .capture(delay: Duration(milliseconds: 10))
//                   .then((capturedImage) async {
//                 // ShowCapturedWidget(context, capturedImage);
//                 getPdf(capturedImage);
//               }).catchError((onError) {
//                 print(onError);
//               });
//             },
//           ),
//           ElevatedButton(
//             child: Text(
//               'Capture An Invisible Widget',
//             ),
//             onPressed: () {
//               var container = Container(
//                   padding: const EdgeInsets.all(30.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.blueAccent, width: 5.0),
//                     color: Colors.redAccent,
//                   ),
//                   child: Text(
//                     "This is an invisible widget",
//                     style: Theme.of(context).textTheme.headline6,
//                   ));
//               screenshotController
//                   .captureFromWidget(
//                       InheritedTheme.captureAll(
//                           context, Material(child: container)),
//                       delay: Duration(seconds: 1))
//                   .then((capturedImage) {
//                 ShowCapturedWidget(context, capturedImage);
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future getPdf(Uint8List screenShot) async {
//     pw.Document pdf = pw.Document();
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Expanded(
//               child: pw.Image(PdfImage.file(pdf.document, bytes: screenShot),
//                   fit: pw.BoxFit.contain));
//         },
//       ),
//     );
//     final path = (await getExternalStorageDirectory()).path;

//     final file = File('$path/example.pdf');
//     await file.writeAsBytes(pdf.save());
//     OpenFile.open('$path/example.pdf');
//   }

//   Future<dynamic> ShowCapturedWidget(
//       BuildContext context, Uint8List capturedImage) {
//     return showDialog(
//       useSafeArea: false,
//       context: context,
//       builder: (context) => Scaffold(
//         appBar: AppBar(
//           title: Text("Captured widget screenshot"),
//         ),
//         body: Center(
//             child: capturedImage != null
//                 ? Image.memory(capturedImage)
//                 : Container()),
//       ),
//     );
//   }

//   // _saved(File image) async {
//   //   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
//   //   print("File Saved to Gallery");
//   // }
// }
