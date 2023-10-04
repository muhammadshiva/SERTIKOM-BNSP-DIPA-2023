import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycashbook_app/shared/shared_methods.dart';
import 'package:mycashbook_app/shared/theme.dart';

class CashFlowItem extends StatefulWidget {
  const CashFlowItem({
    Key? key,
    required this.caption,
    required this.date,
    required this.amount,
    required this.status,
  }) : super(key: key);

  final String caption;
  final String date;
  final int amount;
  final String status;

  @override
  State<CashFlowItem> createState() => _CashFlowItemState();
}

class _CashFlowItemState extends State<CashFlowItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
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
                  // transaction.transactionType!.name.toString(),
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
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
