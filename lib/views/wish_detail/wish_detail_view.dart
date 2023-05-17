import 'package:celenganku/controllers/bloc/wish/wish_bloc.dart';
import 'package:celenganku/models/saving_model.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/views/wish_detail/widgets/custom_expandable_tab.dart';
import 'package:celenganku/views/wish_detail/widgets/detail_saving_info_content.dart';
import 'package:celenganku/views/wish_detail/widgets/detail_time_info_content.dart';
import 'package:celenganku/views/wish_detail/widgets/image_detail_content.dart';

import 'package:celenganku/views/wish_detail/widgets/title_detail_content.dart';
import 'package:celenganku/views/wish_detail/widgets/wish_complete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import '../../utils/widgets/saving_list_content.dart';

class WishDetailView extends StatelessWidget {
  final WishModel wish;
  const WishDetailView({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => WishBloc(wish: wish),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          title: BlocBuilder<WishBloc, WishState>(
            builder: (context, state) {
              return Text(
                state.wish.name,
              );
            },
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocListener<WishBloc, WishState>(
          listener: (context, state) async {
            if (state.wish.completedAt != null) {
              await Future.delayed(const Duration(milliseconds: 500)).then(
                (_) => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const WishCompleteDialog(),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BlocBuilder<WishBloc, WishState>(
                  builder: (context, state) {
                    final String? imagePath = state.wish.imagePath;
                    final WishModel newWish = state.wish;
                    return Card(
                      child: Column(
                        children: [
                          ImageDetailContent(imagePath: imagePath),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 28.0,
                            ),
                            child: Column(
                              children: [
                                TitleDetailContent(wish: newWish),
                                const Divider(height: 24),
                                DetailTimeInfoContent(wish: newWish),
                                const Divider(height: 24),
                                DetailSavingInfoContent(wish: newWish),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                BlocBuilder<WishBloc, WishState>(
                  builder: (context, state) {
                    if (state.wish.listSaving.isEmpty) {
                      return const SizedBox();
                    } else {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 128),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: state.wish.listSaving.length,
                          padding: const EdgeInsets.only(
                              top: 8, right: 28, left: 28),
                          itemBuilder: (context, index) {
                            final SavingModel saving =
                                state.wish.listSaving[index];
                            final bool firstIndex = index == 0;
                            return SavingListContent(
                              saving: saving,
                              firstIndex: firstIndex,
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const CustomExpandableFab(),
      ),
    );
  }
}
