import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mycashbook_app/ui/pages/about_page.dart';
import 'package:mycashbook_app/ui/pages/cash_flow/view/cash_flow_page.dart';
import 'package:mycashbook_app/ui/pages/cash_flow/view/cash_flow_page.dart';
import 'package:mycashbook_app/ui/pages/home/view/home_page.dart';
import 'package:mycashbook_app/ui/pages/income/view/add_income_page.dart';
import 'package:mycashbook_app/ui/pages/income/view/list_income_page.dart';
import 'package:mycashbook_app/ui/pages/outcome/view/list_outcome_page.dart';
import 'package:mycashbook_app/ui/pages/profile/view/edit_profile_page.dart';
import 'package:mycashbook_app/ui/pages/profile/view/profile_page.dart';
import 'package:mycashbook_app/ui/pages/sign_in_page.dart';
import 'package:mycashbook_app/ui/pages/sign_up_page.dart';
import 'package:mycashbook_app/ui/pages/splash_page.dart';

import 'shared/theme.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: lightBgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: lightBgColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: blackColor,
          ),
          titleTextStyle: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/list-income': (context) => const ListIncomePage(),
        '/add-income': (context) => const AddIncomePage(),
        '/list-outcome': (context) => const ListOutcomePage(),
        '/cash-flow': (context) => CashFlowPage(),
        '/profile': (context) => ProfilePage(),
        '/edit-profile': (context) => EditProfilePage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
