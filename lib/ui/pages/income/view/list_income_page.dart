import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycashbook_app/data/controller/cash_flow_controller.dart';
import 'package:mycashbook_app/data/controller/global_controller.dart';
import 'package:mycashbook_app/data/helper/database_helper.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/pages/home/view/home_page.dart';
import 'package:mycashbook_app/ui/pages/income/view/add_income_page.dart';
import 'package:mycashbook_app/ui/widgets/buttons.dart';
import 'package:mycashbook_app/ui/widgets/cash_flow_detail_item.dart';

class ListIncomePage extends StatefulWidget {
  const ListIncomePage({super.key});

  @override
  State<ListIncomePage> createState() => _ListIncomePageState();
}

class _ListIncomePageState extends State<ListIncomePage> {
  final GlobalController globalController = Get.put(GlobalController());
  // Fetch Income
  List<Map<String, dynamic>> incomes = [];

  bool isLoading = true;

  int balance = 0;
  int totalIncome = 0;

  int calculateTotalIncome() {
    for (var income in incomes) {
      totalIncome += income['amount'] as int;
    }
    return totalIncome;
  }

  void refreshIncome() async {
    final data = await DatabaseHelper.getItems();

    setState(() {
      incomes = data;
      isLoading = false;
    });
    print('Income : $incomes');
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
        title: const Text('Detail Income'),
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
          : incomes.isEmpty
              ? Center(
                  child: Text(
                    'No income added.',
                    style: blackTextStyle.copyWith(fontSize: 16),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      Text(
                        'Total Income',
                        style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => Text(
                          formatCurrency(globalController.income.value),
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                            color: greenColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: incomes.where((income) => income['status'] == 'income').map((income) {
                          return CashFlowDetailItem(
                            id: income['id'],
                            caption: income['caption'],
                            amount: income['amount'],
                            date: income['date'],
                            status: income['status'],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: SizedBox(
        child: CustomFilledButton(
          isAdd: true,
          title: 'Add Income',
          width: 160,
          onPressed: () {
            Get.toNamed('/add-income');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
