import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {Key? key,
      required this.title,
      this.obscureText = false,
      this.controller,
      this.isShowTitle = true,
      this.keyboardType,
      this.onFieldSubmitted,
      this.isCurrencyField = false,
      this.isDateField = false,
      this.enable = true})
      : super(key: key);

  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;
  final bool isCurrencyField;
  final bool isDateField;
  final bool? enable;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller?.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
            style: blackTextStyle.copyWith(fontWeight: medium),
          ),
        if (widget.isShowTitle) const SizedBox(height: 8),
        TextFormField(
          readOnly: widget.isDateField == false ? false : true,
          onTap: widget.isDateField == false ? null : () => _selectDate(context),
          obscureText: widget.obscureText,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            enabled: widget.enable!,
            hintText: !widget.isShowTitle ? widget.title : null,
            hintStyle: greyTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
            prefixIcon: widget.isCurrencyField
                ? Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Rp ',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : null,
            suffixIcon: widget.isDateField
                ? GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(
              minWidth: 0, // Mengatur lebar minimum suffixIcon menjadi 0
            ),
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}
