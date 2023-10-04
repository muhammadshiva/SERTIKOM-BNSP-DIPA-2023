import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mycashbook_app/data/helper/database_helper.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';
import 'package:mycashbook_app/ui/pages/income/view/edit_income_page.dart';
import 'package:mycashbook_app/ui/pages/income/view/list_income_page.dart';
import 'package:mycashbook_app/ui/pages/outcome/view/edit_outcome_page.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class CashFlowDetailItem extends StatefulWidget {
  CashFlowDetailItem({
    Key? key,
    required this.id,
    required this.caption,
    required this.date,
    required this.amount,
    required this.status,
  }) : super(key: key);

  final int id;
  final String caption;
  final String date;
  final int amount;
  final String status;

  @override
  State<CashFlowDetailItem> createState() => _CashFlowDetailItemState();
}

class _CashFlowDetailItemState extends State<CashFlowDetailItem> {
  bool isLoading = false;

  void deleteItem(int id) async {
    isLoading = true;
    await DatabaseHelper.deleteItem(id);
    Get.snackbar(
      "Success",
      "Delete Success",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    isLoading = false;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListIncomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: -1,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              widget.status == 'income' ? 'assets/ic_income_green.png' : 'assets/ic_outcome_red.png',
              width: 48,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.caption,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('d MMMM y', 'id_ID').format(DateTime.parse(widget.date)),
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${widget.status == 'income' ? '' : '-'} ${formatCurrency(
                widget.amount,
              )}',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
            ),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return ['Edit', 'Delete'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: InkWell(
                      onTap: () {
                        if (choice == 'Edit') {
                          widget.status == 'income'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditIncomePage(
                                      caption: widget.caption,
                                      amount: widget.amount,
                                      date: widget.date,
                                      id: widget.id,
                                    ),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditOutcomePage(
                                      caption: widget.caption,
                                      amount: widget.amount,
                                      date: widget.date,
                                      id: widget.id,
                                    ),
                                  ),
                                );
                        } else {
                          PanaraConfirmDialog.show(
                            context,
                            title: "Delete",
                            noImage: true,
                            message: "Are you sure want to delete ?",
                            confirmButtonText: "Delete",
                            cancelButtonText: "Cancel",
                            onTapCancel: () {
                              Navigator.pop(context);
                            },
                            onTapConfirm: () {
                              deleteItem(widget.id);
                            },
                            panaraDialogType: PanaraDialogType.error,
                            barrierDismissible: false,
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Icon(choice == 'Edit' ? Icons.edit : Icons.delete),
                          const SizedBox(width: 10),
                          Text(choice),
                        ],
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
