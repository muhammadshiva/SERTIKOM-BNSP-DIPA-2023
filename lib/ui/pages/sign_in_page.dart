import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycashbook_app/data/controller/global_controller.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/widgets/buttons.dart';
import 'package:mycashbook_app/ui/widgets/forms.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalController globalController = Get.put(GlobalController());

  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    globalController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              height: 49,
              width: 191,
              margin: const EdgeInsets.only(
                top: 65,
                bottom: 100,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ic_logo_blue.png'),
                ),
              ),
            ),
            Text(
              'Sign in &\nManage Your Finance',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    title: 'Email Address',
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    title: 'Password',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 30),
                  CustomFilledButton(
                    title: 'Sign In',
                    onPressed: () {
                      if (validate()) {
                        if (emailController.text != globalController.email.value) {
                          showCustomSnackbar(context, 'Wrong email.');
                        } else if (passwordController.text != globalController.password.value) {
                          showCustomSnackbar(context, 'Wrong password.');
                        } else if (emailController.text == globalController.email.value &&
                            passwordController.text == globalController.password.value) {
                          globalController.loginAccount();
                        }
                      } else {
                        showCustomSnackbar(context, 'Fill all fields.');
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/sign-up',
                  (route) => false,
                );
              },
              child: Text(
                'Create New Account',
                style: greyTextStyle.copyWith(fontSize: 16, fontWeight: regular),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
