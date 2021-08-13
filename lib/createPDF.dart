
import 'package:demo_receipt/utils/CreatePDF.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlutterPdf extends StatefulWidget {
  FlutterPdf({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyState createState() => MyState();
}

class MyState extends State<FlutterPdf> {
  @override
  void initState() {
    super.initState();
  }

  List<dynamic> _generateTableData() {
    return [
      {"userId": 1, "name": "John Doe", "email": "john@john.com"},
      {"userId": 2, "name": "John Doe", "email": "john@john.com"},
      {"userId": 3, "name": "John Doe", "email": "john@john.com"},
      {"userId": 4, "name": "John Doe", "email": "john@john.com"},
      {"userId": 5, "name": "John Doe", "email": "john@john.com"},
      {"userId": 6, "name": "John Doe", "email": "john@john.com"},
      {"userId": 7, "name": "John Doe", "email": "john@john.com"},
      {"userId": 8, "name": "John Doe", "email": "john@john.com"},
      {"userId": 9, "name": "John Doe", "email": "john@john.com"},
      {"userId": 10, "name": "John Doe", "email": "john@john.com"},
      {"userId": 1, "name": "John Doe", "email": "john@john.com"},
      {"userId": 2, "name": "John Doe", "email": "john@john.com"},
      {"userId": 3, "name": "John Doe", "email": "john@john.com"},
      {"userId": 4, "name": "John Doe", "email": "john@john.com"},
      {"userId": 5, "name": "John Doe", "email": "john@john.com"},
      {"userId": 6, "name": "John Doe", "email": "john@john.com"},
      {"userId": 7, "name": "John Doe", "email": "john@john.com"},
      {"userId": 8, "name": "John Doe", "email": "john@john.com"},
      {"userId": 9, "name": "John Doe", "email": "john@john.com"},
      {"userId": 10, "name": "John Doe", "email": "john@john.com"},
      {"userId": 1, "name": "John Doe", "email": "john@john.com"},
      {"userId": 2, "name": "John Doe", "email": "john@john.com"},
      {"userId": 3, "name": "John Doe", "email": "john@john.com"},
      {"userId": 4, "name": "John Doe", "email": "john@john.com"},
      {"userId": 5, "name": "John Doe", "email": "john@john.com"},
      {"userId": 6, "name": "John Doe", "email": "john@john.com"},
      {"userId": 7, "name": "John Doe", "email": "john@john.com"},
      {"userId": 8, "name": "John Doe", "email": "john@john.com"},
      {"userId": 9, "name": "John Doe", "email": "john@john.com"},
      {"userId": 10, "name": "John Doe", "email": "john@john.com"}
    ];
  }

  DataRow _getDataRow(dynamic data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          data['userId'].toString(),
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data['name'].toString(),
          style: TextStyle(fontSize: 14),
        )),
        DataCell(Text(
          data['email'].toString(),
          style: TextStyle(fontSize: 14),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DataColumn> tableColumns() {
      return [
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            child: Text(
              "Id",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            child: Text(
              "Name",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            child: Text(
              "Email",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        )
      ];
    }

    Widget makeBody() {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              headingRowHeight: 30,
              columnSpacing: 15,
              dataRowHeight: 35,
              sortAscending: true,
              columns: tableColumns(),
              rows: List.generate(
                _generateTableData().length,
                (index) => _getDataRow(_generateTableData()[index]),
              ),
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter PDF",
          style: TextStyle(
            fontFamily: 'NexaBold',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                //check permission and export file
                var columns = ["Id", "Name", "Email"];
                generatePDF(columns, _generatePDFData()).then((value) {
                  if (value)
                    showSuccessToast();
                  else
                    showErrorToast();
                });
              },
              child: Text(
                "Export PDF",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: makeBody(),
    );
  }

  _generatePDFData() {
    List<List<String>> data = new List();
    for (dynamic d in _generateTableData())
      data.add(<String>[d['userId'].toString(), d['name'], d['email']]);
    return data;
  }
}
