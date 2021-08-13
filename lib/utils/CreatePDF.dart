
import 'package:flutter/material.dart' as material;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

const PdfColor green = PdfColor.fromInt(0xffe06c6c); //darker background color
const PdfColor lightGreen =
PdfColor.fromInt(0xffedabab); //light background color

const _darkColor = PdfColor.fromInt(0xff242424);
const _lightColor = PdfColor.fromInt(0xff9D9D9D);
const PdfColor baseColor = PdfColor.fromInt(0xffD32D2D);
const PdfColor _baseTextColor = PdfColor.fromInt(0xffffffff);
const PdfColor accentColor = PdfColor.fromInt(0xfff1c0c0);


//create pdf file
Future<bool>generatePDF( List<String> columns, List<List<String>> tableData)  async {
  final PageTheme pageTheme = await _myPageTheme(PdfPageFormat.a3);

  Widget headerWidget=pdfHeader();

  final Document pdf = Document();
  pdf.addPage(MultiPage(
      pageTheme: pageTheme,
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container();
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        Header(
          level: 0,
          child: headerWidget,
        ),
        Table.fromTextArray(
          context: context,
          border: null,
          headerAlignment: Alignment.centerLeft,
          cellAlignment: Alignment.centerLeft,
          headerDecoration: BoxDecoration(
            borderRadius: 2,
            color: baseColor,
          ),
          headerHeight: 25,
          cellHeight: 30,
          headerStyle: TextStyle(
            color: _baseTextColor,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          cellStyle: const TextStyle(
            color: _darkColor,
            fontSize: 10,
          ),
          rowDecoration: BoxDecoration(
            border: BoxBorder(
              bottom: true,
              color: accentColor,
              width: .5,
            ),
          ),

          headers: List<String>.generate(
            columns.length,
                (col) {
              return columns[col];
            },
          ),
          data: List<List<String>>.generate(
            tableData.length,
                (row) => List<String>.generate(
              columns.length,
                  (col) {
                return tableData[row][col];
              },
            ),
          ),
        ),
      ]));

  try {
    Directory dir = await getExternalStorageDirectory();
    String filePath = dir.path + "/devbybit/";
    if (Directory(filePath).exists() != true) {
      new Directory(filePath).createSync(recursive: true);
      final File file = File(filePath + "sample.pdf");
      file.writeAsBytesSync(pdf.save());
      return true;
    } else {
      final File file = File(filePath + "sample.pdf");
      file.writeAsBytesSync(pdf.save());
      return true;
    }
  } catch (e) {
    return false;
  }

}


showSuccessToast() {
  Fluttertoast.showToast(
      msg:
      "Your file has been exported successfully.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 60,
      backgroundColor: material.Colors.blueAccent,
      textColor: material.Colors.white,
      fontSize: 16.0);
}

showErrorToast() {
  Fluttertoast.showToast(
      msg: "Exporting your file failed. Nothing was downloaded.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 60,
      backgroundColor: material.Colors.redAccent,
      textColor: material.Colors.white,
      fontSize: 16.0);
}
//pdf document theme
Future<PageTheme> _myPageTheme(PdfPageFormat format) async {
  return PageTheme(
    pageFormat: format.applyMargin(
        left: 2.0 * PdfPageFormat.cm,
        top: 4.0 * PdfPageFormat.cm,
        right: 2.0 * PdfPageFormat.cm,
        bottom: 2.0 * PdfPageFormat.cm),
    theme: ThemeData.withFont(
//      base: pw.Font.ttf(await rootBundle.load('assets/fonts/nexa_bold.otf')),
//      bold:
//          pw.Font.ttf(await rootBundle.load('assets/fonts/raleway_medium.ttf')),
    ),
    buildBackground: (Context context) {
      return FullPage(
        ignoreMargins: true,
        child: CustomPaint(
          size: PdfPoint(format.width, format.height),
          painter: (PdfGraphics canvas, PdfPoint size) {
            context.canvas
              ..setColor(lightGreen)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 230)
              ..lineTo(60, size.y)
              ..fillPath()
              ..setColor(green)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 100)
              ..lineTo(100, size.y)
              ..fillPath()
              ..setColor(lightGreen)
              ..moveTo(30, size.y)
              ..lineTo(110, size.y - 50)
              ..lineTo(150, size.y)
              ..fillPath()
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 230)
              ..lineTo(size.x - 60, 0)
              ..fillPath()
              ..setColor(green)
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 100)
              ..lineTo(size.x - 100, 0)
              ..fillPath()
              ..setColor(lightGreen)
              ..moveTo(size.x - 30, 0)
              ..lineTo(size.x - 110, 50)
              ..lineTo(size.x - 150, 0)
              ..fillPath();
          },
        ),
      );
    },
  );
}

 //pdf header body
Widget pdfHeader() {
  return Container(
      decoration: const BoxDecoration(
          color: PdfColor.fromInt(0xffffffff), borderRadius: 6),
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 4),
      child: Column(children: [
        Text(
          "DevByBit",
          style: TextStyle(
              fontSize: 16, color: _darkColor, fontWeight: FontWeight.bold),
        ),
        Text("+254 700 123456",
            style: TextStyle(fontSize: 14, color: _darkColor)),
        Text("Nairobi, Kenya",
            style: TextStyle(fontSize: 14, color: _darkColor)),
        Divider(color: accentColor),

      ]));
}
