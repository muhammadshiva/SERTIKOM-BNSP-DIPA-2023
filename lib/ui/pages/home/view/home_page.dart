import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycashbook_app/data/controller/global_controller.dart';
import 'package:mycashbook_app/data/helper/database_helper.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/widgets/cash_flow_item.dart';
import 'package:mycashbook_app/ui/widgets/home_service_item.dart';
import 'package:mycashbook_app/ui/widgets/home_tips_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> itemsData = [];
  bool isLoading = true;
  final GlobalController globalController = Get.put(GlobalController());

  void loadData() async {
    final data = await DatabaseHelper.getItems();

    setState(() {
      itemsData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadData();
    globalController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 275,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset('assets/bg_home_profile.png'),
                  Positioned(
                    right: 35,
                    left: 35,
                    bottom: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Howdy',
                              style: whiteTextStyle.copyWith(fontSize: 14),
                            ),
                            Text(
                              globalController.fullname.value,
                              style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/profile_pic.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 35,
                    left: 35,
                    bottom: 110,
                    child: Column(
                      children: [
                        Text(
                          'Total Amount of Saldo',
                          style: whiteTextStyle.copyWith(fontSize: 16),
                        ),
                        Obx(
                          () => Text(
                            'Rp. ${globalController.balance.value}',
                            style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 200,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Warna bayangan
                                offset: Offset(0, 2), // X: 0, Y: 2
                                blurRadius: 8, // Blur: 8
                                spreadRadius: -1, // Spread: -1
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          width: 160,
                          height: 68,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/ic_income.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Total Income',
                                    style: greyTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Text(
                                  formatCurrency(globalController.income.value),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Warna bayangan
                                offset: Offset(0, 2), // X: 0, Y: 2
                                blurRadius: 8, // Blur: 8
                                spreadRadius: -1, // Spread: -1
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          width: 160,
                          height: 68,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/ic_outcome.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Total Outcome',
                                    style: greyTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Text(
                                  formatCurrency(globalController.outcome.value),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildServices(context),
            buildCashFlowItem(),
            // buildFriendlyTips(),
          ],
        ),
      ),
    );
  }

  Widget buildServices(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do Something',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeServiceItem(
                  iconUrl: 'assets/ic_income_dark.png',
                  title: 'Income',
                  onTap: () {
                    Navigator.pushNamed(context, '/list-income');
                  },
                ),
                HomeServiceItem(
                  iconUrl: 'assets/ic_outcome_dark.png',
                  title: 'Outcome',
                  onTap: () {
                    Navigator.pushNamed(context, '/list-outcome');
                  },
                ),
                HomeServiceItem(
                  iconUrl: 'assets/ic_cashflow.png',
                  title: 'Cash Flow',
                  onTap: () {
                    Navigator.pushNamed(context, '/cash-flow');
                  },
                ),
                HomeServiceItem(
                  iconUrl: 'assets/ic_person.png',
                  title: 'Profile',
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCashFlowItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cash Flow',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 395),
              margin: const EdgeInsets.only(top: 14),
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
        ),
      ),
    );
  }

  Widget buildFriendlyTips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Friendly Tips',
              style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 17,
              runSpacing: 18,
              children: [
                HomeTipsItem(),
                HomeTipsItem(),
                HomeTipsItem(),
                HomeTipsItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
