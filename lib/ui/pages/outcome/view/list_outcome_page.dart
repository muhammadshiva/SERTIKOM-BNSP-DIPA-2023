import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycashbook_app/data/controller/cash_flow_controller.dart';
import 'package:mycashbook_app/data/controller/global_controller.dart';
import 'package:mycashbook_app/data/helper/database_helper.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/pages/home/view/home_page.dart';
import 'package:mycashbook_app/ui/pages/income/view/add_income_page.dart';
import 'package:mycashbook_app/ui/pages/outcome/view/add_outcome_page.dart';
import 'package:mycashbook_app/ui/widgets/buttons.dart';
import 'package:mycashbook_app/ui/widgets/cash_flow_detail_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOutcomePage extends StatefulWidget {
  const ListOutcomePage({super.key});

  @override
  State<ListOutcomePage> createState() => _ListOutcomePageState();
}

class _ListOutcomePageState extends State<ListOutcomePage> {
  final GlobalController globalController = Get.put(GlobalController());
  // Fetch Income
  List<Map<String, dynamic>> outcomes = [];

  bool isLoading = true;

  int balance = 0;
  int totalOutcome = 0;

  int calculateTotalOutcome() {
    for (var outcome in outcomes) {
      totalOutcome += outcome['amount'] as int;
    }
    return totalOutcome;
  }

  void refreshIncome() async {
    final data = await DatabaseHelper.getItems();

    setState(() {
      outcomes = data;
      isLoading = false;
    });
    print('Income : $outcomes');
  }

  @override
  void initState() {
    refreshIncome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Outcome'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : outcomes.isEmpty
              ? Center(
                  child: Text(
                    'No outcome added.',
                    style: blackTextStyle.copyWith(fontSize: 16),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      Text(
                        'Total Outcome',
                        style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => Text(
                          formatCurrency(globalController.outcome.value),
                          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: medium, color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: outcomes.where((outcome) => outcome['status'] == 'outcome').map((outcome) {
                          return CashFlowDetailItem(
                            id: outcome['id'],
                            caption: outcome['caption'],
                            amount: outcome['amount'],
                            date: outcome['date'],
                            status: outcome['status'],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: SizedBox(
        child: CustomFilledButton(
          isAdd: true,
          title: 'Add Outcome',
          width: 175,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddOutcomePage(),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
