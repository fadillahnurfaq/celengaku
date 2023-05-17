part of 'add_wish_bloc.dart';

class AddWishState extends Equatable {
  final WishModel wish;

  final String errorMessage;
  final bool isLoading;
  final bool addSuccess;
  const AddWishState({
    required this.wish,
    required this.errorMessage,
    required this.isLoading,
    required this.addSuccess,
  });

  @override
  List<Object> get props => [
        wish,
        errorMessage,
        isLoading,
        addSuccess,
      ];

  AddWishState copyWith({
    WishModel? wish,
    String? errorMessage,
    bool? isLoading,
    bool? addSuccess,
  }) {
    return AddWishState(
      wish: wish ?? this.wish,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      addSuccess: addSuccess ?? this.addSuccess,
    );
  }
}
