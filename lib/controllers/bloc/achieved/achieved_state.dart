part of 'achieved_bloc.dart';

abstract class AchievedState extends Equatable {
  const AchievedState();

  @override
  List<Object> get props => [];
}

class AchievedInitialState extends AchievedState {}

class AchievedLoadingState extends AchievedState {
  const AchievedLoadingState();
}

class AchievedDeleteSuccessState extends AchievedState {
  final String message;
  const AchievedDeleteSuccessState(this.message);
  @override
  List<Object> get props => [message];
}

class AchievedErrorState extends AchievedState {
  final String error;
  const AchievedErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class AchievedLoadedState extends AchievedState {
  final List<WishModel> wishList;
  const AchievedLoadedState(this.wishList);

  @override
  List<Object> get props => [wishList];
}
