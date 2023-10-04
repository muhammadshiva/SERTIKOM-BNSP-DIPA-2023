import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final List<FlSpot> incomeData = [
    FlSpot(1, 5000), // Januari
    FlSpot(2, 6000), // Februari
    FlSpot(3, 7000), // Maret
    // ... Lanjutkan untuk bulan-bulan berikutnya
  ];

  final List<FlSpot> expenseData = [
    FlSpot(1, 3000), // Januari
    FlSpot(2, 3500), // Februari
    FlSpot(3, 4000), // Maret
    // ... Lanjutkan untuk bulan-bulan berikutnya
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line Chart Flutter'),
      ),
      body: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,

                // getTitles: (value) {
                //   switch (value.toInt()) {
                //     case 1:
                //       return 'Jan';
                //     case 2:
                //       return 'Feb';
                //     case 3:
                //       return 'Mar';
                //     // ... Lanjutkan hingga Desember
                //     default:
                //       return '';
                //   }
                // },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: 8000, // Sesuaikan dengan rentang pengeluaran Anda
          lineBarsData: [
            LineChartBarData(
              spots: incomeData,
              isCurved: true,
              color: Colors.green,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: expenseData,
              isCurved: true,
              color: Colors.red,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}











// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mycashbook_app/data/controller/global_controller.dart';
// import 'package:mycashbook_app/data/helper/database_helper.dart';
// import 'package:mycashbook_app/ui/widgets/cash_flow_item.dart';

// class ChartPage extends StatefulWidget {
//   const ChartPage({super.key});

//   @override
//   State<ChartPage> createState() => _ChartPageState();
// }

// class _ChartPageState extends State<ChartPage> {
//   List<Map<String, dynamic>> itemsData = [];
//   bool isLoading = true;
//   final GlobalController globalController = Get.put(GlobalController());

//   void loadData() async {
//     final data = await DatabaseHelper.getItems();

//     setState(() {
//       itemsData = data;
//       isLoading = false;
//     });

//     print('Item Data : $data');
//   }

//   @override
//   void initState() {
//     loadData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Line Chart Flutter'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: itemsData.map((income) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Amount : ${income['amount']}'),
//                 Text('Date : ${income['date']}'),
//                 Text('Status : ${income['status']}'),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }


// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:mycashbook_app/data/controller/global_controller.dart';
// // import 'package:mycashbook_app/data/helper/database_helper.dart';

// // class ChartPage extends StatefulWidget {
// //   const ChartPage({super.key});

// //   @override
// //   State<ChartPage> createState() => _ChartPageState();
// // }

// // class _ChartPageState extends State<ChartPage> {
// //   List<Map<String, dynamic>> itemsData = [];
// //   bool isLoading = true;
// //   final GlobalController globalController = Get.put(GlobalController());

// //   void loadData() async {
// //     final data = await DatabaseHelper.getItems();

// //     setState(() {
// //       itemsData = data;
// //       isLoading = false;
// //     });
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Line Chart Flutter'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: LineChart(
// //           LineChartData(
// //             gridData: FlGridData(show: false),
// //             titlesData: FlTitlesData(show: false),
// //             borderData: FlBorderData(
// //               show: true,
// //               border: Border.all(
// //                 color: const Color(0xff37434d),
// //                 width: 1,
// //               ),
// //             ),
// //             minX: 0,
// //             maxX: 7,
// //             minY: 0,
// //             maxY: 6,
// //             lineBarsData: [
// //               LineChartBarData(
// //                 spots: [
// //                   FlSpot(0, 3),
// //                   FlSpot(1, 1),
// //                   FlSpot(2, 4),
// //                   FlSpot(3, 2),
// //                   FlSpot(4, 5),
// //                   FlSpot(5, 4),
// //                   FlSpot(6, 6),
// //                 ],
// //                 isCurved: true,
// //                 color: Colors.blue,
// //                 dotData: FlDotData(show: false),
// //                 belowBarData: BarAreaData(show: false),
// //               ),
// //               LineChartBarData(
// //                 spots: [
// //                   FlSpot(0, 3),
// //                   FlSpot(2, 1),
// //                   FlSpot(3, 4),
// //                   FlSpot(3, 5),
// //                   FlSpot(4, 6),
// //                   FlSpot(5, 7),
// //                   FlSpot(6, 6),
// //                 ],
// //                 isCurved: true,
// //                 color: Colors.red,
// //                 dotData: FlDotData(show: false),
// //                 belowBarData: BarAreaData(show: false),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
