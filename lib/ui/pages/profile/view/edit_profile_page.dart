import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mycashbook_app/data/controller/global_controller.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/pages/profile/view/profile_page.dart';
import 'package:mycashbook_app/ui/widgets/buttons.dart';
import 'package:mycashbook_app/ui/widgets/forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final usernameController = TextEditingController(text: '');
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final GlobalController globalController = Get.put(GlobalController());

  @override
  void initState() {
    usernameController.text = globalController.username.value;
    nameController.text = globalController.fullname.value;
    emailController.text = globalController.email.value;
    passwordController.text = globalController.password.value;
    super.initState();
  }

  bool isLoading = false;

  void update() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fullname', nameController.text);
    prefs.setString('username', usernameController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('password', passwordController.text);
    Get.snackbar(
      "Success",
      "Update Success",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    isLoading = false;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
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
                        title: 'Username',
                        controller: usernameController,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        title: 'Full Name',
                        controller: nameController,
                      ),
                      const SizedBox(height: 16),
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
                        title: 'Update',
                        onPressed: () {
                          update();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
