part of 'app_theme_cubit.dart';

abstract class AppThemeState extends Equatable {
  final ThemeMode? themeMode;
  const AppThemeState({this.themeMode});

  @override
  List<Object> get props => [themeMode ?? ThemeMode.system];
}

class AppThemeInitial extends AppThemeState {
  const AppThemeInitial({super.themeMode = ThemeMode.system});
}

class AppThemeLoaded extends AppThemeState {
  const AppThemeLoaded({required super.themeMode});
}
