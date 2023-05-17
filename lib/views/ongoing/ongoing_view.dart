import 'package:celenganku/controllers/bloc/on_going/on_going_bloc.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/views/create_wish/create_wish_view.dart';
import 'package:celenganku/views/ongoing/widget/ongoing_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingView extends StatelessWidget {
  const OngoingView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) => OnGoingBloc()..add(const GetWishListEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: BlocBuilder<OnGoingBloc, OnGoingState>(
            builder: (context, state) {
              if (state is OnGoingLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OnGoingErrorState) {
                return Center(
                  child: Text("Gagal mendapatkan data celangan ${state.error}"),
                );
              }
              if (state is OnGoingLoadedState) {
                if (state.wishList.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada data"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.wishList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      final WishModel wish = state.wishList[index];

                      return OngoingContent(
                        wish: wish,
                      );
                    },
                  );
                }
              }

              return const SizedBox();
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => const CreateWithView(),
                  ))
                  .then((_) => context.read<OnGoingBloc>()
                    ..add(const GetWishListEvent()));
            },
            label: const Text(
              "Tambah Celengan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}
