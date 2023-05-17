import 'package:celenganku/controllers/cubit/app_theme/app_theme_cubit.dart';
import 'package:celenganku/utils/theme.dart';
import 'package:celenganku/views/splash_view.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppThemeCubit(),
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (BuildContext context, AppThemeState state) {
          print("state ${state.themeMode}");
          return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
              final ColorScheme lightColorScheme =
                  CustomTheme.lightColorScheme(lightDynamic);
              final ColorScheme darkColorScheme =
                  CustomTheme.darkColorScheme(darkDynamic);
              return MaterialApp(
                title: "Celenganku By Atlit Gagal Dev",
                home: const SplashView(),
                theme: CustomTheme.lightTheme(lightColorScheme),
                darkTheme: CustomTheme.darkTheme(darkColorScheme),
                debugShowCheckedModeBanner: false,
                themeMode: state.themeMode,
              );
            },
          );
        },
      ),
    );
  }
}
