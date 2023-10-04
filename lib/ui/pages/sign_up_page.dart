import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycashbook_app/data/controller/global_controller.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/widgets/buttons.dart';
import 'package:mycashbook_app/ui/widgets/forms.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (globalController.isLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                Container(
                  height: 49,
                  width: 191,
                  margin: const EdgeInsets.only(
                    top: 50,
                    bottom: 50,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/ic_logo_blue.png'),
                    ),
                  ),
                ),
                Text(
                  'Sign up &\nNew Account',
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
                        title: 'Full Name',
                        controller: globalController.fullNameController,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        title: 'Username',
                        controller: globalController.userNameController,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        title: 'Email',
                        controller: globalController.emailController,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        title: 'Password',
                        obscureText: true,
                        controller: globalController.passwordController,
                      ),
                      const SizedBox(height: 30),
                      CustomFilledButton(
                        title: 'Continue',
                        onPressed: () {
                          if (globalController.validate()) {
                            globalController.register();
                          } else {
                            showCustomSnackbar(context, 'Please fill in all fields');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/sign-in',
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: greyTextStyle.copyWith(fontSize: 16, fontWeight: regular),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            );
          }
        }),
      ),
    );
  }
}
