import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/views/achieved/widgets/achieved_wish_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/bloc/achieved/achieved_bloc.dart';

class AchievedView extends StatelessWidget {
  const AchievedView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => AchievedBloc()..add(GetAchievedWishEvent()),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: BlocBuilder<AchievedBloc, AchievedState>(
          builder: (context, state) {
            if (state is AchievedLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AchievedLoadedState) {
              if (state.wishList.isEmpty) {
                return const Center(
                  child: Text("Tidak ada data"),
                );
              } else {
                return ListView.builder(
                  itemCount: state.wishList.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    final WishModel wish = state.wishList[index];
                    return AchievedWishListItem(wish: wish);
                  },
                );
              }
            }
            if (state is AchievedErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
