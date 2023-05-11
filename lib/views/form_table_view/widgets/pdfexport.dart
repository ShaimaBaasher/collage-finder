import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> makePdf(List<Map<String, dynamic>> items) async {
  List<pw.Widget> widgets = [];
  for (int i = 0; i < items.length; i++) {
    widgets.add(
      pw.Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Table(
            //   border: TableBorder.all(color: PdfColors.black),
            //   children: [
            //     TableRow(
            //       children: [
            //         Padding(
            //           child: Text(
            //             'Virtual Application Form',
            //             style: TextStyle(fontSize: 19.sp,),
            //             textAlign: TextAlign.center,
            //           ),
            //           padding: const EdgeInsets.all(20),
            //         ),
            //       ],
            //     ),
            //     ...items.map(
            //           (e) => TableRow(
            //         children: [
            //           Expanded(
            //             child: PaddedText(e["itinerary"]),
            //             flex: 2,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
        //
        pw.Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          pw.Text(
            '${i + 1} - ',
            style: pw.TextStyle(
              fontSize: 18.sp,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(width: 2.w,),
          pw.Text(
            '${items[i]['itinerary']}',
            style: pw.TextStyle(
              fontSize: 18.sp,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ])
      ]),
    );

    widgets.add(pw.SizedBox(height: 1.h));
    widgets.add(pw.Divider(color: PdfColors.grey));
    widgets.add(pw.SizedBox(height: 1.h));
  }

  final pdf = Document();
  pdf.addPage(
    MultiPage(
      build: (context) => widgets, //here goes the widgets list
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17.0.sp,
        ),
        textAlign: align,
      ),
    );

// Column(
// children: [
// Table(
// border: TableBorder.all(color: PdfColors.black),
// children: [
// TableRow(
// children: [
// Padding(
// child: Text(
// 'Virtual Application Form',
// style: TextStyle(  fontSize: 19.sp,),
// textAlign: TextAlign.center,
// ),
// padding: const EdgeInsets.all(20),
// ),
// ],
// ),
// ...items.map(
// (e) => TableRow(
// children: [
// Expanded(
// child: PaddedText(e["itinerary"]),
// flex: 2,
// ),
// ],
// ),
// ),
// ],
// ),
// ],
// );
