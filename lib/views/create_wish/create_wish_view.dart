import 'package:celenganku/controllers/bloc/add_wish/add_wish_bloc.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/dialog/custom_dialog.dart';
import 'package:celenganku/utils/validator/validator.dart';
import 'package:celenganku/views/create_wish/widget/custom_text_form_field.dart';
import 'package:celenganku/views/create_wish/widget/select_image_wish.dart';
import 'package:celenganku/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateWithView extends StatelessWidget {
  const CreateWithView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController namaTabunganController =
        TextEditingController(text: "");
    final TextEditingController targetTabunganController =
        TextEditingController(text: "");
    final TextEditingController nominalPengisianController =
        TextEditingController(text: "");
    final WishModel wish = WishModel(
      id: '0',
      name: '',
      savingTarget: 0,
      savingPlan: SavingPlan.daily,
      savingNominal: 0,
      listSaving: const [],
      createdAt: DateTime.now(),
    );
    return BlocProvider(
      create: (context) => AddWishBloc(wish: wish),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            Builder(builder: (context) {
              return BlocConsumer<AddWishBloc, AddWishState>(
                listener: (context, state) {
                  if (state.isLoading == true) {
                    CustomDialog.showLoading(context);
                  }
                  if (state.errorMessage.isNotEmpty) {
                    CustomDialog.hideLoading(context);
                    CustomDialog.showAlert(
                        "Error", state.errorMessage, context);
                  }
                  if (state.addSuccess == true) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                          (route) => false);
                    });
                  }
                },
                builder: (context, state) {
                  final WishModel wish = state.wish;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          return;
                        } else {
                          FocusScope.of(context).unfocus();

                          context.read<AddWishBloc>().add(
                                SaveWishEvent(
                                  WishModel(
                                    id: const Uuid().v4(),
                                    name: namaTabunganController.text,
                                    savingTarget: int.tryParse(
                                            targetTabunganController.text
                                                .replaceAll(".", "")) ??
                                        0,
                                    savingPlan: wish.savingPlan,
                                    savingNominal: int.tryParse(
                                            nominalPengisianController.text
                                                .replaceAll(".", "")) ??
                                        0,
                                    listSaving: wish.listSaving,
                                    createdAt: DateTime.now(),
                                    imagePath: wish.imagePath,
                                  ),
                                ),
                              );
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Simpan",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              );
            })
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SelectImageWish(),
                const SizedBox(
                  height: 16.0,
                ),
                QTextFormField(
                  controller: namaTabunganController,
                  labelText: "Nama Tabungan",
                  prefixIcon: Icons.notes,
                  validator: (String? value) {
                    return Validator.required(
                        value, "Nama tabungan harus diisi");
                  },
                  isCurrency: false,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                QTextFormField(
                  controller: targetTabunganController,
                  labelText: "Target Tabungan",
                  prefixIcon: Icons.money,
                  prefixText: "Rp. ",
                  validator: (String? value) {
                    return Validator.required(
                        value, "Target Tabungan tidak boleh kosong");
                  },
                  isCurrency: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Rencana Pengisian",
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<AddWishBloc, AddWishState>(
                      builder: (context, state) {
                        return SegmentedButton<SavingPlan>(
                          onSelectionChanged: (newSelection) {
                            context.read<AddWishBloc>().add(
                                WishSavingPlanChangedEvent(
                                    savingPlan: newSelection.first));
                          },
                          showSelectedIcon: false,
                          segments: const [
                            ButtonSegment(
                              value: SavingPlan.daily,
                              label: Text('Harian'),
                            ),
                            ButtonSegment(
                              value: SavingPlan.weekly,
                              label: Text('Mingguan'),
                            ),
                            ButtonSegment(
                              value: SavingPlan.monthly,
                              label: Text('Bulanan'),
                            ),
                          ],
                          selected: {state.wish.savingPlan},
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BlocBuilder<AddWishBloc, AddWishState>(
                  builder: (context, state) {
                    final WishModel wish = state.wish;
                    return QTextFormField(
                      controller: nominalPengisianController,
                      labelText: "Nominal Pengisian",
                      prefixIcon: Icons.money,
                      prefixText: "Rp. ",
                      validator: (String? value) {
                        return Validator.nominal(
                            value,
                            targetTabunganController.text,
                            wish.savingPlan,
                            "Target per ${WishModel.savingPlanTimeName(wish.savingPlan).toLowerCase()} tidak boleh kosong");
                      },
                      isCurrency: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
