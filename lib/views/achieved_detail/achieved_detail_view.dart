import 'package:celenganku/models/saving_model.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/dialog/custom_dialog.dart';
import 'package:celenganku/utils/widgets/saving_list_content.dart';
import 'package:celenganku/views/achieved_detail/widgets/achieved_detail_image.dart';
import 'package:celenganku/views/achieved_detail/widgets/achieved_detail_info.dart';
import 'package:celenganku/views/achieved_detail/widgets/show_delete_wish_dialog.dart';
import 'package:celenganku/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../controllers/bloc/achieved/achieved_bloc.dart';

class AchievedDetailView extends StatelessWidget {
  final WishModel wish;
  const AchievedDetailView({super.key, required this.wish});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final String? imagePath = wish.imagePath;
    return BlocProvider(
      create: (context) => AchievedBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: AppBar(
              title: Text(wish.name),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              actions: [
                BlocListener<AchievedBloc, AchievedState>(
                  listener: (context, state) {
                    if (state is AchievedErrorState) {
                      Fluttertoast.showToast(msg: state.error);
                    }
                    if (state is AchievedLoadingState) {
                      CustomDialog.showLoading(context);
                    }
                    if (state is AchievedDeleteSuccessState) {
                      CustomDialog.hideLoading(context);
                      Fluttertoast.showToast(msg: state.message);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider.value(
                              value: context.read<AchievedBloc>(),
                              child: ShowDeleteWishDialog(
                                wish: wish,
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Hapus",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        AchievedDetailImage(imagePath: imagePath, theme: theme),
                        AchievedDetailInfo(wish: wish),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (wish.listSaving.isNotEmpty)
                    Card(
                      margin: const EdgeInsets.only(bottom: 128.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          right: 28.0,
                          left: 28.0,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: wish.listSaving.length,
                          itemBuilder: (context, index) {
                            final SavingModel saving = wish.listSaving[index];
                            final bool firstIndex = index == 0;
                            return SavingListContent(
                              saving: saving,
                              firstIndex: firstIndex,
                            );
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
