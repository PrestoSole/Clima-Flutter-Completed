import 'dart:convert';

import 'package:clima_data/models/full_weather_model.dart';
import 'package:clima_data/utils/date_time.dart' as date_time_utils;
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/daily_forecast.dart';
import 'package:clima_domain/entities/hourly_forecast.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:test/test.dart';

void main() {
  group('FullWeatherModel', () {
    test('fromJson', () {
      final json = jsonDecode(
        '{"lat":0.1257,"lon":51.5085,"timezone":"Etc/GMT-3","timezone_offset":10800,"current":{"dt":1634313115,"sunrise":1634264178,"sunset":1634307772,"temp":27.16,"feels_like":29.5,"pressure":1011,"humidity":74,"dew_point":22.12,"uvi":0,"clouds":8,"visibility":10000,"wind_speed":7.5,"wind_deg":178,"wind_gust":7.79,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}]},"hourly":[{"dt":1634310000,"temp":27.16,"feels_like":29.5,"pressure":1011,"humidity":74,"dew_point":22.12,"uvi":0,"clouds":8,"visibility":10000,"wind_speed":7.76,"wind_deg":178,"wind_gust":8.23,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1634313600,"temp":27.16,"feels_like":29.5,"pressure":1011,"humidity":74,"dew_point":22.12,"uvi":0,"clouds":8,"visibility":10000,"wind_speed":7.5,"wind_deg":178,"wind_gust":7.79,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1634317200,"temp":27.15,"feels_like":29.48,"pressure":1011,"humidity":74,"dew_point":22.11,"uvi":0,"clouds":8,"visibility":10000,"wind_speed":7.05,"wind_deg":178,"wind_gust":7.36,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1634320800,"temp":27.15,"feels_like":29.48,"pressure":1011,"humidity":74,"dew_point":22.11,"uvi":0,"clouds":9,"visibility":10000,"wind_speed":6.63,"wind_deg":177,"wind_gust":6.85,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"pop":0},{"dt":1634324400,"temp":27.14,"feels_like":29.56,"pressure":1012,"humidity":75,"dew_point":22.32,"uvi":0,"clouds":60,"visibility":10000,"wind_speed":6.46,"wind_deg":179,"wind_gust":6.81,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0},{"dt":1634328000,"temp":27.12,"feels_like":29.42,"pressure":1011,"humidity":74,"dew_point":22.08,"uvi":0,"clouds":78,"visibility":10000,"wind_speed":6.45,"wind_deg":185,"wind_gust":6.8,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0},{"dt":1634331600,"temp":27.12,"feels_like":29.24,"pressure":1010,"humidity":72,"dew_point":21.75,"uvi":0,"clouds":97,"visibility":10000,"wind_speed":6.2,"wind_deg":188,"wind_gust":6.45,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634335200,"temp":27.25,"feels_like":29.19,"pressure":1010,"humidity":69,"dew_point":21.13,"uvi":0,"clouds":98,"visibility":10000,"wind_speed":5.57,"wind_deg":195,"wind_gust":5.81,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634338800,"temp":27.35,"feels_like":29.17,"pressure":1010,"humidity":67,"dew_point":20.77,"uvi":0,"clouds":98,"visibility":10000,"wind_speed":5.27,"wind_deg":202,"wind_gust":5.52,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634342400,"temp":27.36,"feels_like":29.18,"pressure":1010,"humidity":67,"dew_point":20.64,"uvi":0,"clouds":98,"visibility":10000,"wind_speed":5.36,"wind_deg":207,"wind_gust":5.49,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634346000,"temp":27.24,"feels_like":28.9,"pressure":1011,"humidity":66,"dew_point":20.51,"uvi":0,"clouds":100,"visibility":10000,"wind_speed":5.49,"wind_deg":201,"wind_gust":5.37,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634349600,"temp":27.1,"feels_like":28.85,"pressure":1011,"humidity":68,"dew_point":20.75,"uvi":0,"clouds":98,"visibility":10000,"wind_speed":6.28,"wind_deg":193,"wind_gust":5.93,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634353200,"temp":26.81,"feels_like":28.47,"pressure":1012,"humidity":69,"dew_point":20.8,"uvi":0.16,"clouds":84,"visibility":10000,"wind_speed":6.28,"wind_deg":193,"wind_gust":6.26,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634356800,"temp":26.86,"feels_like":28.62,"pressure":1012,"humidity":70,"dew_point":20.87,"uvi":1.18,"clouds":66,"visibility":10000,"wind_speed":5.74,"wind_deg":190,"wind_gust":6.29,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634360400,"temp":26.79,"feels_like":28.58,"pressure":1012,"humidity":71,"dew_point":21.14,"uvi":3.63,"clouds":59,"visibility":10000,"wind_speed":5,"wind_deg":183,"wind_gust":5.8,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634364000,"temp":26.88,"feels_like":28.73,"pressure":1012,"humidity":71,"dew_point":21.2,"uvi":7.22,"clouds":62,"visibility":10000,"wind_speed":4.42,"wind_deg":184,"wind_gust":5.37,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634367600,"temp":27.19,"feels_like":29.09,"pressure":1011,"humidity":69,"dew_point":20.98,"uvi":10.85,"clouds":44,"visibility":10000,"wind_speed":4.77,"wind_deg":187,"wind_gust":5.49,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1634371200,"temp":27.4,"feels_like":29.25,"pressure":1010,"humidity":67,"dew_point":20.7,"uvi":13.15,"clouds":30,"visibility":10000,"wind_speed":5.71,"wind_deg":193,"wind_gust":6.03,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1634374800,"temp":27.36,"feels_like":29.09,"pressure":1009,"humidity":66,"dew_point":20.6,"uvi":13.3,"clouds":37,"visibility":10000,"wind_speed":6.3,"wind_deg":193,"wind_gust":6.3,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1634378400,"temp":27.18,"feels_like":28.98,"pressure":1008,"humidity":68,"dew_point":20.69,"uvi":11.44,"clouds":40,"visibility":10000,"wind_speed":6.29,"wind_deg":195,"wind_gust":6.38,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1634382000,"temp":27.09,"feels_like":28.92,"pressure":1008,"humidity":69,"dew_point":20.85,"uvi":7.88,"clouds":49,"visibility":10000,"wind_speed":5.94,"wind_deg":198,"wind_gust":6.24,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1634385600,"temp":27.12,"feels_like":29.06,"pressure":1008,"humidity":70,"dew_point":21.12,"uvi":4.16,"clouds":58,"visibility":10000,"wind_speed":6.04,"wind_deg":197,"wind_gust":6.51,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634389200,"temp":27.16,"feels_like":29.13,"pressure":1008,"humidity":70,"dew_point":21.27,"uvi":1.45,"clouds":100,"visibility":10000,"wind_speed":5.81,"wind_deg":199,"wind_gust":6.26,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1634392800,"temp":27.15,"feels_like":29.2,"pressure":1009,"humidity":71,"dew_point":21.41,"uvi":0.23,"clouds":99,"visibility":10000,"wind_speed":5.81,"wind_deg":199,"wind_gust":6.15,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"pop":0},{"dt":1634396400,"temp":27.1,"feels_like":29.11,"pressure":1010,"humidity":71,"dew_point":21.41,"uvi":0,"clouds":90,"visibility":10000,"wind_speed":5.35,"wind_deg":199,"wind_gust":5.57,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634400000,"temp":27.05,"feels_like":29.03,"pressure":1010,"humidity":71,"dew_point":21.37,"uvi":0,"clouds":89,"visibility":10000,"wind_speed":4.68,"wind_deg":200,"wind_gust":4.9,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634403600,"temp":27.02,"feels_like":28.97,"pressure":1011,"humidity":71,"dew_point":21.42,"uvi":0,"clouds":92,"visibility":10000,"wind_speed":4.8,"wind_deg":196,"wind_gust":4.98,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634407200,"temp":26.94,"feels_like":28.92,"pressure":1011,"humidity":72,"dew_point":21.56,"uvi":0,"clouds":92,"visibility":10000,"wind_speed":5.19,"wind_deg":195,"wind_gust":5.41,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634410800,"temp":26.92,"feels_like":28.96,"pressure":1011,"humidity":73,"dew_point":21.73,"uvi":0,"clouds":89,"visibility":10000,"wind_speed":5.16,"wind_deg":191,"wind_gust":5.45,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634414400,"temp":26.9,"feels_like":29.01,"pressure":1010,"humidity":74,"dew_point":21.78,"uvi":0,"clouds":94,"visibility":10000,"wind_speed":5.02,"wind_deg":190,"wind_gust":5.32,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634418000,"temp":26.9,"feels_like":28.93,"pressure":1010,"humidity":73,"dew_point":21.65,"uvi":0,"clouds":94,"visibility":10000,"wind_speed":5.25,"wind_deg":189,"wind_gust":5.45,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634421600,"temp":26.98,"feels_like":28.9,"pressure":1009,"humidity":71,"dew_point":21.45,"uvi":0,"clouds":94,"visibility":10000,"wind_speed":5.57,"wind_deg":189,"wind_gust":5.75,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634425200,"temp":27.01,"feels_like":29.04,"pressure":1009,"humidity":72,"dew_point":21.49,"uvi":0,"clouds":93,"visibility":10000,"wind_speed":5.24,"wind_deg":185,"wind_gust":5.54,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"pop":0},{"dt":1634428800,"temp":26.91,"feels_like":28.95,"pressure":1009,"humidity":73,"dew_point":21.74,"uvi":0,"clouds":82,"visibility":10000,"wind_speed":4.76,"wind_deg":180,"wind_gust":5.34,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"pop":0},{"dt":1634432400,"temp":26.88,"feels_like":28.97,"pressure":1010,"humidity":74,"dew_point":21.92,"uvi":0,"clouds":21,"visibility":10000,"wind_speed":4.3,"wind_deg":174,"wind_gust":4.9,"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"pop":0},{"dt":1634436000,"temp":26.97,"feels_like":29.23,"pressure":1011,"humidity":75,"dew_point":22.09,"uvi":0,"clouds":44,"visibility":10000,"wind_speed":4.66,"wind_deg":167,"wind_gust":5,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"pop":0},{"dt":1634439600,"temp":27.05,"feels_like":29.29,"pressure":1011,"humidity":74,"dew_point":22,"uvi":0.16,"clouds":56,"visibility":10000,"wind_speed":5.61,"wind_deg":167,"wind_gust":5.64,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634443200,"temp":27.26,"feels_like":29.5,"pressure":1012,"humidity":72,"dew_point":21.86,"uvi":1.18,"clouds":67,"visibility":10000,"wind_speed":6.09,"wind_deg":169,"wind_gust":6.05,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634446800,"temp":27.34,"feels_like":29.64,"pressure":1012,"humidity":72,"dew_point":21.96,"uvi":3.62,"clouds":63,"visibility":10000,"wind_speed":6.56,"wind_deg":172,"wind_gust":6.57,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634450400,"temp":27.31,"feels_like":29.59,"pressure":1012,"humidity":72,"dew_point":21.86,"uvi":7.2,"clouds":62,"visibility":10000,"wind_speed":6.42,"wind_deg":166,"wind_gust":6.71,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634454000,"temp":27.32,"feels_like":29.51,"pressure":1011,"humidity":71,"dew_point":21.7,"uvi":10.88,"clouds":1,"visibility":10000,"wind_speed":6.26,"wind_deg":164,"wind_gust":7.02,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"pop":0},{"dt":1634457600,"temp":27.34,"feels_like":29.64,"pressure":1010,"humidity":72,"dew_point":21.79,"uvi":13.19,"clouds":20,"visibility":10000,"wind_speed":6.55,"wind_deg":167,"wind_gust":7.37,"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"pop":0},{"dt":1634461200,"temp":27.38,"feels_like":29.72,"pressure":1009,"humidity":72,"dew_point":21.89,"uvi":13.34,"clouds":18,"visibility":10000,"wind_speed":6.52,"wind_deg":169,"wind_gust":7.37,"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"pop":0},{"dt":1634464800,"temp":27.41,"feels_like":29.78,"pressure":1009,"humidity":72,"dew_point":21.95,"uvi":11.32,"clouds":19,"visibility":10000,"wind_speed":5.95,"wind_deg":167,"wind_gust":6.58,"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"pop":0},{"dt":1634468400,"temp":27.54,"feels_like":30.02,"pressure":1009,"humidity":72,"dew_point":22.02,"uvi":7.8,"clouds":27,"visibility":10000,"wind_speed":5.89,"wind_deg":163,"wind_gust":6.26,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1634472000,"temp":27.61,"feels_like":30.16,"pressure":1009,"humidity":72,"dew_point":22.14,"uvi":4.11,"clouds":32,"visibility":10000,"wind_speed":5.85,"wind_deg":169,"wind_gust":6.16,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0},{"dt":1634475600,"temp":27.55,"feels_like":30.39,"pressure":1009,"humidity":75,"dew_point":22.7,"uvi":1.43,"clouds":83,"visibility":10000,"wind_speed":5.76,"wind_deg":166,"wind_gust":6.14,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"pop":0},{"dt":1634479200,"temp":27.47,"feels_like":30.46,"pressure":1009,"humidity":77,"dew_point":23.12,"uvi":0.23,"clouds":47,"visibility":10000,"wind_speed":5.19,"wind_deg":170,"wind_gust":5.81,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"pop":0}],"daily":[{"dt":1634284800,"sunrise":1634264178,"sunset":1634307772,"moonrise":1634294400,"moonset":1634249520,"moon_phase":0.33,"temp":{"day":27.12,"min":26.71,"max":27.17,"night":27.12,"eve":27.16,"morn":27.03},"feels_like":{"day":29.33,"night":29.42,"eve":29.41,"morn":29.52},"pressure":1011,"humidity":73,"dew_point":21.95,"wind_speed":8.15,"wind_deg":181,"wind_gust":8.55,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":5,"pop":0.24,"rain":0.12,"uvi":13.31},{"dt":1634371200,"sunrise":1634350565,"sunset":1634394159,"moonrise":1634383740,"moonset":1634338980,"moon_phase":0.36,"temp":{"day":27.4,"min":26.79,"max":27.4,"night":26.9,"eve":27.15,"morn":27.1},"feels_like":{"day":29.25,"night":29.01,"eve":29.2,"morn":28.85},"pressure":1010,"humidity":67,"dew_point":20.7,"wind_speed":6.3,"wind_deg":193,"wind_gust":6.51,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":30,"pop":0,"uvi":13.3},{"dt":1634457600,"sunrise":1634436952,"sunset":1634480546,"moonrise":1634472900,"moonset":1634428260,"moon_phase":0.4,"temp":{"day":27.34,"min":26.88,"max":27.61,"night":27.18,"eve":27.47,"morn":26.97},"feels_like":{"day":29.64,"night":30.04,"eve":30.46,"morn":29.23},"pressure":1010,"humidity":72,"dew_point":21.79,"wind_speed":6.56,"wind_deg":172,"wind_gust":7.37,"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":20,"pop":0,"uvi":13.34},{"dt":1634544000,"sunrise":1634523341,"sunset":1634566935,"moonrise":1634561880,"moonset":1634517360,"moon_phase":0.43,"temp":{"day":27.55,"min":26.91,"max":27.69,"night":27.45,"eve":27.5,"morn":27.03},"feels_like":{"day":30.39,"night":30.53,"eve":30.88,"morn":29.62},"pressure":1010,"humidity":75,"dew_point":22.84,"wind_speed":6.04,"wind_deg":154,"wind_gust":6.21,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":6,"pop":0,"uvi":13.16},{"dt":1634630400,"sunrise":1634609729,"sunset":1634653323,"moonrise":1634650800,"moonset":1634606280,"moon_phase":0.46,"temp":{"day":27.3,"min":27.1,"max":27.39,"night":27.38,"eve":27.39,"morn":27.1},"feels_like":{"day":30.2,"night":30.37,"eve":30.51,"morn":29.67},"pressure":1011,"humidity":78,"dew_point":23.18,"wind_speed":6.61,"wind_deg":168,"wind_gust":6.67,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":97,"pop":0.06,"uvi":12.12},{"dt":1634716800,"sunrise":1634696119,"sunset":1634739713,"moonrise":1634739780,"moonset":1634695200,"moon_phase":0.5,"temp":{"day":27.36,"min":26.9,"max":27.45,"night":26.9,"eve":27.44,"morn":26.99},"feels_like":{"day":30.56,"night":29.43,"eve":30.62,"morn":29.63},"pressure":1011,"humidity":80,"dew_point":23.61,"wind_speed":5.63,"wind_deg":167,"wind_gust":5.9,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":64,"pop":0.7,"rain":1.15,"uvi":13},{"dt":1634803200,"sunrise":1634782509,"sunset":1634826103,"moonrise":1634828700,"moonset":1634784180,"moon_phase":0.52,"temp":{"day":27.4,"min":26.84,"max":27.53,"night":27.11,"eve":27.5,"morn":27.02},"feels_like":{"day":30.3,"night":29.79,"eve":30.4,"morn":29.41},"pressure":1011,"humidity":77,"dew_point":22.93,"wind_speed":4.89,"wind_deg":207,"wind_gust":4.86,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":69,"pop":0.58,"rain":3.46,"uvi":13},{"dt":1634889600,"sunrise":1634868900,"sunset":1634912494,"moonrise":1634917680,"moonset":1634873100,"moon_phase":0.55,"temp":{"day":27.26,"min":26.85,"max":27.5,"night":27.25,"eve":27.5,"morn":26.85},"feels_like":{"day":29.9,"night":29.88,"eve":30.29,"morn":29.24},"pressure":1011,"humidity":76,"dew_point":22.71,"wind_speed":3.92,"wind_deg":224,"wind_gust":4.19,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":34,"pop":0.74,"rain":1.77,"uvi":13}]}',
      ) as Map<String, dynamic>;
      const city = City(name: 'London');

      final fullWeather =
          FullWeatherModel.fromJson(json, city: city).fullWeather;

      expect(fullWeather.city, city);
      expect(fullWeather.timeZoneOffset, const Duration(seconds: 10800));
      expect(
        fullWeather.currentWeather,
        Weather(
          date: date_time_utils.fromUtcUnixTime(1634313115),
          sunrise: date_time_utils.fromUtcUnixTime(1634264178),
          sunset: date_time_utils.fromUtcUnixTime(1634307772),
          temperature: 27.16,
          tempFeel: 29.5,
          pressure: 1011,
          humidity: 74,
          uvIndex: 0,
          windSpeed: 7.5 * 3.6,
          condition: 800,
          iconCode: "01n",
          description: "clear sky",
          minTemperature: 26.71,
          maxTemperature: 27.17,
        ),
      );

      expect(
        fullWeather.hourlyForecasts[0],
        HourlyForecast(
          temperature: 27.16,
          iconCode: "01n",
          date: date_time_utils.fromUtcUnixTime(1634310000),
          pop: 0,
        ),
      );

      expect(
        fullWeather.dailyForecasts[0],
        DailyForecast(
          date: date_time_utils.fromUtcUnixTime(1634284800),
          iconCode: '10d',
          minTemperature: 26.71,
          maxTemperature: 27.17,
          pop: 0.24,
        ),
      );
    });
  });
}
