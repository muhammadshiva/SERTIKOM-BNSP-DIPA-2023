import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycashbook_app/data/controller/cash_flow_controller.dart';
import 'package:mycashbook_app/data/controller/global_controller.dart';
import 'package:mycashbook_app/data/helper/database_helper.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/pages/income/view/list_income_page.dart';
import 'package:mycashbook_app/ui/pages/outcome/view/list_outcome_page.dart';
import 'package:mycashbook_app/ui/widgets/buttons.dart';
import 'package:mycashbook_app/ui/widgets/forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOutcomePage extends StatelessWidget {
  const AddOutcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());

    final dateController = TextEditingController(text: '');
    final amountController = TextEditingController(text: '');
    final captionController = TextEditingController(text: '');

    bool validate() {
      if (amountController.text.isEmpty || captionController.text.isEmpty) {
        return false;
      }
      return true;
    }

    bool isLoading = false;

    // Insert Item To Database
    Future<void> addItem() async {
      isLoading = true;
      await DatabaseHelper.createItem(dateController.text, int.parse(amountController.text), captionController.text, 'outcome');
      await globalController.subtractBalance(int.parse(amountController.text));
      isLoading = false;
      Get.offAllNamed('/list-outcome');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Outcome'),
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
                        title: 'Date',
                        controller: dateController,
                        isDateField: true,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        title: 'Amount',
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        isCurrencyField: true,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        title: 'Caption',
                        obscureText: false,
                        controller: captionController,
                      ),
                      const SizedBox(height: 30),
                      CustomFilledButton(
                        title: 'Save',
                        onPressed: () async {
                          if (validate()) {
                            await addItem();
                          } else {
                            showCustomSnackbar(context, 'Please fill in all fields');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
    );
  }
}
