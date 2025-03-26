import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/theme/theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();

    bool isDarkMode = themeCubit.isDarkMode;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Switch(
          value: isDarkMode,
          onChanged: (value) {
            themeCubit.toggleTheme();
          },
        ),
      ),
    );
  }
}
