part of 'on_going_bloc.dart';

abstract class OnGoingState extends Equatable {
  const OnGoingState();

  @override
  List<Object> get props => [];
}

class OnGoingInitialState extends OnGoingState {
  const OnGoingInitialState();
}

class OnGoingLoadingState extends OnGoingState {
  const OnGoingLoadingState();
}

class OnGoingErrorState extends OnGoingState {
  final String error;
  const OnGoingErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class OnGoingLoadedState extends OnGoingState {
  final List<WishModel> wishList;
  const OnGoingLoadedState(this.wishList);

  @override
  List<Object> get props => [wishList];
}
