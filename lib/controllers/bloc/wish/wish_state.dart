part of 'wish_bloc.dart';

class WishState extends Equatable {
  final WishModel wish;
  final bool isLoading;
  final String successMessage;
  final String errorMessage;
  const WishState({
    required this.wish,
    required this.isLoading,
    required this.successMessage,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        wish,
        isLoading,
        successMessage,
        errorMessage,
      ];

  WishState copyWith({
    WishModel? wish,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return WishState(
      wish: wish ?? this.wish,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
