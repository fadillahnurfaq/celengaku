part of 'add_wish_bloc.dart';

abstract class AddWishEvent extends Equatable {
  const AddWishEvent();

  @override
  List<Object> get props => [];
}

class WishImageChangedEvent extends AddWishEvent {
  final String imagePath;
  const WishImageChangedEvent({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class WishSavingPlanChangedEvent extends AddWishEvent {
  final SavingPlan savingPlan;
  const WishSavingPlanChangedEvent({required this.savingPlan});

  @override
  List<Object> get props => [savingPlan];
}

class SaveWishEvent extends AddWishEvent {
  final WishModel wish;
  const SaveWishEvent(
    this.wish,
  );

  @override
  List<Object> get props => [
        wish,
      ];
}
