import 'package:flutter/material.dart';

import 'expandable_textfield.dart';

class SavingFormDialog extends StatelessWidget {
  final String title;
  final VoidCallback onSubmit;
  final TextEditingController nominalController, keteranganController;
  final GlobalKey<FormState> formKey;
  final String? Function(String?) validator;
  const SavingFormDialog({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.nominalController,
    required this.keteranganController,
    required this.formKey,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      contentPadding: const EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ExpandableTextfield(
                controller: nominalController,
                labelText: "Nominal",
                validator: validator,
                prefixText: "Rp. ",
                isCurrency: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ExpandableTextfield(
                controller: keteranganController,
                labelText: "Keterangan (Opsional)",
                validator: (p0) {
                  return null;
                },
                isCurrency: false,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Batal"),
        ),
        TextButton(
          onPressed: onSubmit,
          child: const Text("Simpan"),
        ),
      ],
    );
  }
}
