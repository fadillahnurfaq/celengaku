import 'package:celenganku/models/saving_model.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/services/wish_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wish_event.dart';
part 'wish_state.dart';

class WishBloc extends Bloc<WishEvent, WishState> {
  WishBloc({required WishModel wish})
      : super(WishState(
          wish: wish,
          isLoading: false,
          successMessage: "",
          errorMessage: "",
        )) {
    on<WishEvent>((event, emit) async {
      if (event is AddSavingEvent) {
        WishModel updateWish = state.wish
            .copyWith(listSaving: [...state.wish.listSaving, event.newSaving]);

        if (updateWish.getTotalSaving() >= updateWish.savingTarget) {
          WishModel completeWish =
              updateWish.copyWith(completedAt: DateTime.now());
          emit(state.copyWith(
            wish: completeWish,
          ));

          await WishService.saveWish(completeWish);
        } else {
          emit(state.copyWith(
            wish: updateWish,
          ));
          await WishService.saveWish(updateWish);
        }
      }
      if (event is TakeSavingEvent) {
        WishModel updatedWish = state.wish.copyWith(
          listSaving: [...state.wish.listSaving, event.newSaving],
        );

        await WishService.saveWish(updatedWish);

        emit(state.copyWith(wish: updatedWish));
      }

      if (event is DeleteWishEvent) {
        try {
          emit(state.copyWith(isLoading: true));
          await Future.delayed(
            const Duration(seconds: 1),
            () async {
              await WishService.deleteWish(state.wish);
            },
          );
          emit(state.copyWith(
              isLoading: false, successMessage: "Berhasil hapus"));
        } catch (e) {
          emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
        }
      }
    });
  }
}
