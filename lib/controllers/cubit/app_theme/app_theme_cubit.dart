import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'app_theme_state.dart';

class AppThemeCubit extends HydratedCubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeInitial());

  void themeChanged(ThemeMode themeMode) {
    emit(AppThemeLoaded(themeMode: themeMode));
  }

  @override
  AppThemeState? fromJson(Map<String, dynamic> json) {
    return AppThemeLoaded(themeMode: ThemeMode.values[json["theme"] as int]);
  }

  @override
  Map<String, dynamic>? toJson(AppThemeState state) {
    return {"theme": state.themeMode?.index};
  }
}
