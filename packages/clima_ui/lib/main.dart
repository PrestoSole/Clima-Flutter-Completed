import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_data/providers.dart';
import 'package:clima_data/repos/city_repo_impl.dart';
import 'package:clima_data/repos/forecasts_repo_impl.dart';
import 'package:clima_data/repos/weather_repo_impl.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:clima_domain/repos/forecasts_repo.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:clima_ui/screens/loading_screen.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart' as t;
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart'
    show themeStateNotifierProvider;
import 'package:clima_ui/themes/black_theme.dart';
import 'package:clima_ui/themes/dark_theme.dart';
import 'package:clima_ui/themes/light_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'themes/clima_theme.dart';

Future<void> main() async {
  // Unless you do this, using method channels (like `SharedPreferences` does)
  // before running `runApp` throws an error.
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        cityRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(cityRepoImplProvider))),
        weatherRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(weatherRepoImplProvider))),
        forecastsRepoProvider.overrideWithProvider(
            Provider((ref) => ref.watch(forecastsRepoImplProvider))),
      ],
      child: DevicePreview(
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final themeStateNotifier = useProvider(themeStateNotifierProvider.notifier);

    useEffect(() {
      themeStateNotifier.loadTheme();

      return null;
    }, [themeStateNotifier]);

    final themeState = useProvider(themeStateNotifierProvider);

    if (themeState is t.EmptyState || themeState is t.Loading) {
      return const SizedBox.shrink();
    }

    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          home: const _Home(),
          theme: lightTheme,
          darkTheme: {
            DarkThemeModel.black: blackTheme,
            DarkThemeModel.darkGrey: darkGreyTheme,
          }[themeState.darkTheme],
          themeMode: const {
            ThemeModel.systemDefault: ThemeMode.system,
            ThemeModel.light: ThemeMode.light,
            ThemeModel.dark: ThemeMode.dark,
          }[themeState.theme],
        );
      },
    );
  }
}

class _Home extends HookWidget {
  const _Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkTheme = useProvider(
        themeStateNotifierProvider.select((state) => state.darkTheme));

    return ClimaTheme(
      data: () {
        switch (Theme.of(context).brightness) {
          case Brightness.light:
            return lightClimaTheme;

          case Brightness.dark:
            return const {
              DarkThemeModel.black: blackClimaTheme,
              DarkThemeModel.darkGrey: darkGreyClimaTheme,
            }[darkTheme];
        }
      }(),
      child: const LoadingScreen(),
    );
  }
}
