import 'package:flutter/material.dart';
import 'package:mycashbook_app/data/helper/database_helper.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/pages/outcome/view/list_outcome_page.dart';
import 'package:mycashbook_app/ui/widgets/buttons.dart';
import 'package:mycashbook_app/ui/widgets/forms.dart';

class EditOutcomePage extends StatefulWidget {
  const EditOutcomePage({
    super.key,
    required this.id,
    required this.caption,
    required this.date,
    required this.amount,
  });

  final int id;
  final String caption;
  final String date;
  final int amount;

  @override
  State<EditOutcomePage> createState() => _EditOutcomePageState();
}

class _EditOutcomePageState extends State<EditOutcomePage> {
  final dateController = TextEditingController(text: '');
  final amountController = TextEditingController(text: '');
  final captionController = TextEditingController(text: '');

  bool validate() {
    if (amountController.text.isEmpty || captionController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    dateController.text = widget.date;
    amountController.text = widget.amount.toString();
    captionController.text = widget.caption;
  }

  bool isLoading = false;

  Future<void> updateItem(int id) async {
    isLoading = true;
    await DatabaseHelper.updateItem(id, dateController.text, int.parse(amountController.text), captionController.text, 'outcome');
    isLoading = false;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListOutcomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Income'),
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
                        enable: false,
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
                            await updateItem(widget.id);
                          } else {
                            showCustomSnackbar(context, 'Semua field harus diisi');
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
