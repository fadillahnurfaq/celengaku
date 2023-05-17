part of 'achieved_bloc.dart';

abstract class AchievedEvent extends Equatable {
  const AchievedEvent();

  @override
  List<Object> get props => [];
}

class GetAchievedWishEvent extends AchievedEvent {}

class DeleteAchievedWishEvent extends AchievedEvent {
  final WishModel wish;
  const DeleteAchievedWishEvent(this.wish);

  @override
  List<Object> get props => [wish];
}
