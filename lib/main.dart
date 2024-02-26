import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/screens/root/root.dart';
import 'package:gym_app/services/user.dart';
import 'package:gym_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
ValueNotifier<bool> isThemeDark = ValueNotifier(false);

const String userBoxName = 'userBox';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  isThemeDark.value = sharedPreferences.getBool('isDark') ?? false;

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('fa'),
        Locale('en'),
      ],
      path: 'assets/translations',
      startLocale: const Locale('fa'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserService.getUsers();
    return ValueListenableBuilder(
      valueListenable: isThemeDark,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(
              context.locale == const Locale('en') ? 'Gilroy' : 'YekanBakh'),
          darkTheme: darkTheme(
              context.locale == const Locale('en') ? 'Gilroy' : 'YekanBakh'),
          themeMode: isThemeDark.value ? ThemeMode.dark : ThemeMode.light,
          home: const RootScreen(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
