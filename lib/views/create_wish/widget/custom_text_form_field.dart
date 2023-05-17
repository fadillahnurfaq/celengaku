import 'package:celenganku/utils/formatter/currentcy_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QTextFormField extends StatelessWidget {
  final bool isCurrency;
  final IconData prefixIcon;
  final String labelText;
  final String? prefixText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  const QTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.validator,
    required this.isCurrency,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isCurrency
          ? const TextInputType.numberWithOptions(decimal: false)
          : null,
      validator: validator,
      inputFormatters: isCurrency
          ? [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ]
          : null,
      decoration: InputDecoration(
        prefixText: prefixText,
        border: _border(),
        focusedBorder: _border(color: Colors.blue, thickness: 2.0),
        enabledBorder: _border(),
        disabledBorder: _border(),
        errorBorder: _border(
          color: Colors.red,
          thickness: 2.0,
        ),
        prefixIcon: Icon(prefixIcon),
        label: Text(labelText),
        counterText: "",
      ),
    );
  }
}

OutlineInputBorder _border({Color? color, double? thickness}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color ?? const Color(0xFF000000),
      width: thickness ?? 1.0,
    ),
  );
}
