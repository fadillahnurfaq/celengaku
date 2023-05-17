import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/services/wish_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'achieved_event.dart';
part 'achieved_state.dart';

class AchievedBloc extends Bloc<AchievedEvent, AchievedState> {
  AchievedBloc() : super(AchievedInitialState()) {
    on<AchievedEvent>((event, emit) async {
      if (event is GetAchievedWishEvent) {
        try {
          emit(const AchievedLoadingState());

          final List<WishModel> wishList = WishService.getAchievedWishList();

          await Future.delayed(
            const Duration(seconds: 1),
            () {
              emit(AchievedLoadedState(wishList));
            },
          );
        } catch (e) {
          emit(AchievedErrorState(e.toString()));
        }
      }
      if (event is DeleteAchievedWishEvent) {
        try {
          emit(const AchievedLoadingState());
          await Future.delayed(
            const Duration(seconds: 2),
            () async {
              await WishService.deleteWish(event.wish);
              emit(const AchievedDeleteSuccessState("Berhasil hapus celengan"));
            },
          );
        } catch (e) {
          emit(AchievedErrorState(e.toString()));
        }
      }
    });
  }
}
