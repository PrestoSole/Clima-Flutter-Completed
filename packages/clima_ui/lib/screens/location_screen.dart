import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima_ui/main.dart';
import 'package:clima_ui/screens/loading_screen.dart';
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'city_screen.dart';

enum Menu { darkModeOn }

/// This function returns the right weather icon for the right condition.
String _getWeatherIcon(int condition) {
  if (condition < 300) {
    return '🌩';
  } else if (condition < 400) {
    return '🌧';
  } else if (condition < 600) {
    return '☔️';
  } else if (condition < 700) {
    return '☃️';
  } else if (condition < 800) {
    return '🌫';
  } else if (condition == 800) {
    return '☀️';
  } else if (condition <= 804) {
    return '☁';
  } else {
    return '🤷‍';
  }
}

class LocationScreen extends StatefulHookWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);
    final weatherState = useProvider(weatherStateNotifierProvider.state);

    if (weatherState is! Loaded) {
      return Scaffold(key: _scaffoldKey, body: const SizedBox.shrink());
    }

    final weather = (weatherState as Loaded).weather;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          '${weather.cityName} (°C)',
          style: Theme.of(context).appBarTheme.textTheme.subtitle1,
        ),
        leading: IconButton(
          color: Theme.of(context).appBarTheme.actionsIconTheme.color,
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoadingScreen(),
              ),
            );
          },
        ),
        actions: <Widget>[
          /// The loading indicator widget.
          Visibility(
            visible: weatherState is Loading,
            child: const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 1.5),
              ),
            ),
          ),

          /// The search button.
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () async {
              final changed = await Navigator.push(
                context,
                MaterialPageRoute<bool>(
                  builder: (BuildContext context) {
                    return CityScreen();
                  },
                ),
              );

              if (changed ?? false) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoadingScreen(),
                  ),
                );
              }
            },
          ),
          PopupMenuButton(
            offset: const Offset(8.0, 8.0),
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              PopupMenuItem<Menu>(
                value: Menu.darkModeOn,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return CheckboxListTile(
                    checkColor: _themeState.isDarkTheme
                        ? Colors.grey.shade900
                        : Colors.white,
                    title: const Text('Dark theme'),
                    value: _themeState.isDarkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        value
                            ? _themeState.setDarkTheme()
                            : _themeState.setLightTheme();
                        Navigator.pop(context);
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// This card displays the temperature, the weather icon, and the weather description.
              ReusableWidgets(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /// Temperature.
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: AutoSizeText(
                              '${weather.temperature.round()}°',
                              style: kTempTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        /// Weather icon.
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: AutoSizeText(
                              _getWeatherIcon(weather.condition),
                              style: kConditionTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Weather description.
                    Center(
                      child: AutoSizeText(
                        '${weather.description[0].toUpperCase()}${weather.description.substring(1)}',
                        maxLines: 1,
                        presetFontSizes: const <double>[30, 25, 20, 15, 10],
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              /// This card displays tempFeel, tempMax, and tempMin.
              ReusableWidgets(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /// TempFeel.
                    Center(
                      child: AutoSizeText(
                        'It feels like ${weather.tempFeel.round()}°',
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    /// TempMax and TempMin.
                    Center(
                      child: AutoSizeText(
                        '↑${weather.tempMax.round()}°/↓${weather.tempMin.round()}°',
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              /// This card displays the wind speed.
              ReusableWidgets(
                cardChild: Center(
                  child: AutoSizeText(
                    'The 💨 speed is \n ${weather.windSpeed.round()} km/h',
                    style: kMessageTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
