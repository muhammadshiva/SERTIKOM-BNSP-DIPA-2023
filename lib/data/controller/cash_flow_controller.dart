import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashFlowController extends GetxController {
  var balance = 0.obs;

  @override
  void onInit() {
    getBalance();
    super.onInit();
  }

  void getBalance() {
    SharedPreferences.getInstance().then((prefs) {
      balance.value = prefs.getInt('balance') ?? 0;
    });
  }

  void setBalance(int _balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('balance', balance.value);
  }
}
