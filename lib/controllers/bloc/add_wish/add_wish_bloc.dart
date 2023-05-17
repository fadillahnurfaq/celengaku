import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/services/wish_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_wish_event.dart';
part 'add_wish_state.dart';

class AddWishBloc extends Bloc<AddWishEvent, AddWishState> {
  AddWishBloc({required WishModel wish})
      : super(AddWishState(
            wish: wish,
            errorMessage: "",
            isLoading: false,
            addSuccess: false)) {
    on<AddWishEvent>((event, emit) async {
      if (event is SaveWishEvent) {
        try {
          emit(state.copyWith(isLoading: true));
          WishModel wish = event.wish;
          await WishService.saveWish(wish);
          emit(state.copyWith(wish: wish, isLoading: false, addSuccess: true));
        } catch (e) {
          emit(state.copyWith(
              isLoading: false, errorMessage: e.toString(), addSuccess: false));
        }
      }

      if (event is WishImageChangedEvent) {
        emit(state.copyWith(
            wish: state.wish.copyWith(imagePath: event.imagePath)));
      }
      if (event is WishSavingPlanChangedEvent) {
        emit(state.copyWith(
            wish: state.wish.copyWith(savingPlan: event.savingPlan)));
      }
    });
  }
}
