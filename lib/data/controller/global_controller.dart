// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var fullname = "".obs;
  var username = "".obs;
  var email = "".obs;
  var password = "".obs;
  var balance = 0.obs;
  var income = 0.obs;
  var outcome = 0.obs;
  var login = false.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() async {
    await SharedPreferences.getInstance().then((prefs) {
      fullname.value = prefs.getString('fullname') ?? '';
      username.value = prefs.getString('username') ?? '';
      email.value = prefs.getString('email') ?? '';
      password.value = prefs.getString('password') ?? '';
      balance.value = prefs.getInt('balance') ?? 0;
      income.value = prefs.getInt('income') ?? 0;
      outcome.value = prefs.getInt('outcome') ?? 0;
      login.value = prefs.getBool('login') ?? false;
    });
  }

  // Fungsi untuk menyimpan data pengguna ke penyimpanan lokal
  void register() async {
    if (validate()) {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('fullname', fullNameController.text);
      prefs.setString('username', userNameController.text);
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setInt('balance', 0);
      prefs.setInt('income', 0);
      prefs.setInt('outcome', 0);
      prefs.setBool('login', true);
      isLoading.value = false;
      Get.offAllNamed('/home');
    }
  }

  bool validate() {
    return !(fullNameController.text.isEmpty || userNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty);
  }

  void refreshBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    balance.value = prefs.getInt('balance') ?? 0;
  }

  Future<void> addBalance(int income) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int currentBalance = prefs.getInt('balance') ?? 0;
    int newBalance = currentBalance + income;

    prefs.setInt('income', currentBalance + income);
    prefs.setInt('balance', newBalance);

    refreshBalance();
  }

  Future<void> updateIncomeBalance(int income) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentBalance = prefs.getInt('balance') ?? 0;
    int currentIncome = prefs.getInt('income') ?? 0;
  }

  Future<void> subtractBalance(int outcome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int currentBalance = prefs.getInt('balance') ?? 0;
    int newBalance = currentBalance - outcome;

    int currentOutcome = prefs.getInt('outcome') ?? 0;
    int newOutcome = currentOutcome + outcome;

    prefs.setInt('outcome', newOutcome);
    prefs.setInt('balance', newBalance);

    refreshBalance();
  }

  Future<void> logout() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', false);
    isLoading.value = false;
    Get.snackbar(
      "Success",
      "Logout Success",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.offAllNamed('/sign-in');
  }

  Future<void> loginAccount() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', true);
    isLoading.value = false;
    Get.snackbar(
      "Success",
      "Login Success",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Navigator.pushNamedAndRemoveUntil(
      Get.context!,
      '/home',
      (route) => false,
    );
  }
}
