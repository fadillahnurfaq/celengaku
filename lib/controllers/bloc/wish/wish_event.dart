part of 'wish_bloc.dart';

abstract class WishEvent extends Equatable {
  const WishEvent();

  @override
  List<Object> get props => [];
}

// class SavingMessageChangedEvent extends WishEvent {
//   const SavingMessageChangedEvent({required this.message});

//   final String message;

//   @override
//   List<Object> get props => [message];
// }

class AddSavingEvent extends WishEvent {
  final SavingModel newSaving;

  const AddSavingEvent(this.newSaving);
  @override
  List<Object> get props => [newSaving];
}

class TakeSavingEvent extends WishEvent {
  final SavingModel newSaving;

  const TakeSavingEvent(this.newSaving);
  @override
  List<Object> get props => [newSaving];
}

class DeleteWishEvent extends WishEvent {
  const DeleteWishEvent();
}
