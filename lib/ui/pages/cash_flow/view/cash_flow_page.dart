import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mycashbook_app/data/helper/database_helper.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/pages/cash_flow/view/chart_page.dart';
import 'package:mycashbook_app/ui/widgets/cash_flow_detail_item.dart';
import 'package:mycashbook_app/ui/widgets/cash_flow_item.dart';
import 'package:mycashbook_app/ui/widgets/forms.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});
  final Color leftBarColor = Colors.green;
  final Color rightBarColor = Colors.red;
  final Color avgColor = Colors.orange;
  @override
  State<StatefulWidget> createState() => CashFlowPageState();
}

class CashFlowPageState extends State<CashFlowPage> {
  final searchController = TextEditingController(text: '');
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  List<Map<String, dynamic>> itemsData = [];

  bool isLoading = true;

  void loadData() async {
    final data = await DatabaseHelper.getItems();

    setState(() {
      itemsData = data;
      isLoading = false;
    });

    print('ITEM DATA : $itemsData');
  }

  @override
  void initState() {
    super.initState();
    loadData();

    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 20, 20);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash Flow'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            // Text(
            //   'Statistic',
            //   style: blackTextStyle.copyWith(
            //     fontWeight: semiBold,
            //     fontSize: 16,
            //   ),
            // ),
            // const SizedBox(height: 14),
            // cashFlowStatistic(),
            // const SizedBox(height: 20),
            buildCashFlowItem(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ChartPage(),
      //         ));
      //   },
      //   child: Text('Chart'),
      // ),
    );
  }

  Widget cashFlowStatistic() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 38,
                  ),
                  const Text(
                    'Cash Flow',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'Statistics',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 20,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (a, b, c, d) => null,
                      ),
                      touchCallback: (FlTouchEvent event, response) {
                        if (response == null || response.spot == null) {
                          setState(() {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          });
                          return;
                        }

                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                        setState(() {
                          if (!event.isInterestedForInteractions) {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                            return;
                          }
                          showingBarGroups = List.of(rawBarGroups);
                          if (touchedGroupIndex != -1) {
                            var sum = 0.0;
                            for (final rod in showingBarGroups[touchedGroupIndex].barRods) {
                              sum += rod.toY;
                            }
                            final avg = sum / showingBarGroups[touchedGroupIndex].barRods.length;

                            showingBarGroups[touchedGroupIndex] = showingBarGroups[touchedGroupIndex].copyWith(
                              barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                return rod.copyWith(toY: avg, color: widget.avgColor);
                              }).toList(),
                            );
                          }
                        });
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  Widget buildCashFlowItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Cash Flow',
        //   style: blackTextStyle.copyWith(
        //     fontWeight: semiBold,
        //     fontSize: 16,
        //   ),
        // ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: whiteColor,
          ),
          child: itemsData.isEmpty
              ? Text(
                  'No transactions.',
                  style: blackTextStyle,
                  textAlign: TextAlign.center,
                )
              : Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: itemsData.map((income) {
                        return CashFlowItem(
                          caption: income['caption'],
                          amount: income['amount'],
                          date: income['date'],
                          status: income['status'],
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
