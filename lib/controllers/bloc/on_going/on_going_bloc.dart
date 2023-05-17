import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/services/wish_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_going_event.dart';
part 'on_going_state.dart';

class OnGoingBloc extends Bloc<OnGoingEvent, OnGoingState> {
  OnGoingBloc() : super(const OnGoingInitialState()) {
    on<OnGoingEvent>((event, emit) async {
      if (event is GetWishListEvent) {
        try {
          emit(const OnGoingLoadingState());
          final List<WishModel> wish = WishService.getOnGoingWishList();
          await Future.delayed(
            const Duration(seconds: 1),
            () => emit(OnGoingLoadedState(wish)),
          );
        } catch (e) {
          emit(OnGoingErrorState(e.toString()));
        }
      }
    });
  }
}
