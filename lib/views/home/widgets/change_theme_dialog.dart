import 'package:celenganku/controllers/cubit/app_theme/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget showChangeThemeDialog(BuildContext context) {
  ThemeData theme = Theme.of(context);
  return Dialog(
    backgroundColor: theme.colorScheme.surface,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              "Pilih Tema",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          BlocBuilder<AppThemeCubit, AppThemeState>(
            builder: (context, state) {
              return Column(
                children: [
                  RadioListTile(
                    value: ThemeMode.system,
                    groupValue: state.themeMode,
                    onChanged: (ThemeMode? value) async {
                      return Future(() {
                        context.read<AppThemeCubit>().themeChanged(value!);
                      }).then((_) => Navigator.pop(context));
                    },
                    title: const Text("Default"),
                  ),
                  RadioListTile(
                    value: ThemeMode.light,
                    groupValue: state.themeMode,
                    onChanged: (ThemeMode? value) async {
                      return Future(() {
                        context.read<AppThemeCubit>().themeChanged(value!);
                      }).then((_) => Navigator.pop(context));
                    },
                    title: const Text("Terang"),
                  ),
                  RadioListTile(
                    value: ThemeMode.dark,
                    groupValue: state.themeMode,
                    onChanged: (ThemeMode? value) async {
                      return Future(() {
                        context.read<AppThemeCubit>().themeChanged(value!);
                      }).then((_) => Navigator.pop(context));
                    },
                    title: const Text("Gelap"),
                  ),
                ],
              );
            },
          )
        ],
      ),
    ),
  );
}
