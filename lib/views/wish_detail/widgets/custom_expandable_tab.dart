import 'package:celenganku/controllers/bloc/wish/wish_bloc.dart';
import 'package:celenganku/models/saving_model.dart';
import 'package:celenganku/utils/dialog/custom_dialog.dart';
import 'package:celenganku/utils/validator/validator.dart';
import 'package:celenganku/views/home/home_view.dart';
import 'package:celenganku/views/wish_detail/widgets/saving_form_dialong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'floating_action_button_content.dart';

class CustomExpandableFab extends StatelessWidget {
  const CustomExpandableFab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nominalController =
        TextEditingController(text: "");
    final TextEditingController keteranganController =
        TextEditingController(text: "");
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocListener<WishBloc, WishState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          Navigator.pop(context);
          CustomDialog.showLoading(context);
        }
        if (state.errorMessage.isNotEmpty) {
          CustomDialog.hideLoading(context);
          Fluttertoast.showToast(msg: state.errorMessage);
        }
        if (state.successMessage.isNotEmpty) {
          CustomDialog.hideLoading(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
              (route) => false);
          Fluttertoast.showToast(msg: state.successMessage);
        }
      },
      child: ExpandableFab(
        distance: 60.0,
        type: ExpandableFabType.up,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(.5),
        ),
        expandedFabSize: ExpandableFabSize.regular,
        closeButtonStyle: ExpandableFabCloseButtonStyle(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            child: const Icon(Icons.close),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16),
          child: const Icon(Icons.edit),
        ),
        children: [
          FloatingActionButtonContent(
            label: "Hapus Tabungan",
            icon: Icons.delete_outline,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: const Text(
                      'Hapus tabungan?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<WishBloc>().add(const DeleteWishEvent());
                        },
                        child: const Text('Hapus'),
                      )
                    ],
                  );
                },
              );
            },
          ),
          FloatingActionButtonContent(
            label: "Ambil Tabungan",
            icon: Icons.remove,
            onTap: () {
              if (context.read<WishBloc>().state.wish.getTotalSaving() <= 0) {
                Fluttertoast.showToast(
                    msg: 'Belum ada tabungan yang terkumpul');
                return;
              } else {
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<WishBloc>(),
                      child: SavingFormDialog(
                        title: "Ambil Tabungan",
                        onSubmit: () {
                          if (!formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            return;
                          } else {
                            FocusScope.of(context).unfocus();
                            final int nominal = int.tryParse(nominalController
                                    .text
                                    .replaceAll(".", "")) ??
                                0;

                            context.read<WishBloc>().add(
                                  TakeSavingEvent(
                                    SavingModel(
                                      savingNominal: nominal * -1,
                                      createdAt: DateTime.now(),
                                      message: keteranganController.text,
                                    ),
                                  ),
                                );
                            Navigator.pop(context);
                          }
                        },
                        nominalController: nominalController,
                        keteranganController: keteranganController,
                        formKey: formKey,
                        validator: (String? value) {
                          if (value!.isEmpty ||
                              value == '' ||
                              int.parse((value).replaceAll('.', '')) <= 0) {
                            return 'Nominal tidak boleh kosong';
                          }
                          if (int.parse((value).replaceAll('.', '')) >
                              context
                                  .read<WishBloc>()
                                  .state
                                  .wish
                                  .getTotalSaving()) {
                            return 'Nominal tidak boleh melebihi total tabungan terkumpul';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
          FloatingActionButtonContent(
            label: "Menabung",
            icon: Icons.add,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<WishBloc>(),
                    child: SavingFormDialog(
                      title: "Menabung",
                      onSubmit: () {
                        if (!formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          return;
                        } else {
                          FocusScope.of(context).unfocus();
                          context.read<WishBloc>().add(
                                AddSavingEvent(
                                  SavingModel(
                                      savingNominal: int.tryParse(
                                              nominalController.text
                                                  .replaceAll(".", "")) ??
                                          0,
                                      createdAt: DateTime.now(),
                                      message: keteranganController.text),
                                ),
                              );
                          Navigator.pop(context);
                        }
                      },
                      nominalController: nominalController,
                      keteranganController: keteranganController,
                      formKey: formKey,
                      validator: (value) {
                        return Validator.required(
                            value, "Nominal tidak boleh kosong");
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
