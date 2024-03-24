// import 'dart:io';
// import 'package:bank_sampah/pdf/handle.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class PdfInvoiceApi {
//   static Future<File> generate(PdfColor color, pw.Font fontFamily) async {
//     final pdf = pw.Document();

//     final iconImage = (await rootBundle.load('assets/images/image1.png'))
//         .buffer
//         .asUint8List();

//     final tableHeaders = [
//       'Kategori Sampah',
//       'Jenis Sampah',
//       'Jumlah',
//       'Total',
//     ];

//     final tableData = [
//       [
//         'Gelasan',
//         'Aqua gelas kotor',
//         '3',
//         '3000',
//       ],
//       [
//         'PET',
//         'PET Kotor',
//         '4',
//         '6000',
//       ],
//     ];

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) {
//           return [
//             pw.Row(
//               children: [
//                 pw.Image(
//                   pw.MemoryImage(iconImage),
//                   height: 72,
//                   width: 72,
//                 ),
//                 pw.SizedBox(width: 1 * PdfPageFormat.mm),
//                 pw.Column(
//                   mainAxisSize: pw.MainAxisSize.min,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       'BANK SAMPAH',
//                       style: pw.TextStyle(
//                         fontSize: 17.0,
//                         fontWeight: pw.FontWeight.bold,
//                         color: color,
//                         font: fontFamily,
//                       ),
//                     ),
//                   ],
//                 ),
//                 pw.Spacer(),
//                 pw.Column(
//                   mainAxisSize: pw.MainAxisSize.min,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Divider(),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Text(
//               'Nama Petugas :\nNama Nasabah :\nTanggal :',
//               textAlign: pw.TextAlign.justify,
//               style: pw.TextStyle(
//                 fontSize: 14.0,
//                 color: color,
//                 font: fontFamily,
//               ),
//             ),
//             pw.SizedBox(height: 5 * PdfPageFormat.mm),

//             ///
//             /// PDF Table Create
//             ///
//             pw.Table.fromTextArray(
//               headers: tableHeaders,
//               data: tableData,
//               border: null,
//               headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               headerDecoration:
//                   const pw.BoxDecoration(color: PdfColors.grey300),
//               cellHeight: 30.0,
//               cellAlignments: {
//                 0: pw.Alignment.centerLeft,
//                 1: pw.Alignment.centerRight,
//                 2: pw.Alignment.centerRight,
//                 3: pw.Alignment.centerRight,
//                 4: pw.Alignment.centerRight,
//               },
//             ),
//             pw.Divider(),
//             pw.Container(
//               alignment: pw.Alignment.centerRight,
//               child: pw.Row(
//                 children: [
//                   pw.Spacer(flex: 6),
//                   pw.Expanded(
//                     flex: 4,
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Row(),
//                         pw.Row(),
//                         pw.Divider(),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Total',
//                                 style: pw.TextStyle(
//                                   fontSize: 14.0,
//                                   fontWeight: pw.FontWeight.bold,
//                                   color: color,
//                                   font: fontFamily,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               'Rp.9000',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                                 color: color,
//                                 font: fontFamily,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                         pw.Container(height: 1, color: PdfColors.grey400),
//                         pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
//                         pw.Container(height: 1, color: PdfColors.grey400),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ];
//         },
//         footer: (context) {
//           return pw.Column(
//             mainAxisSize: pw.MainAxisSize.min,
//           );
//         },
//       ),
//     );

//     return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }
// }
