import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app2/components/index.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app2/secrets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = 'London';

  // openWeatherAPIKey is API key value stored on /lib/secrets.dart, API key is given from openWeather after signup
  Future<Map<String,dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body); // convert from json format to string

      if (data['cod'] != '200') {
        throw 'An expected error occurred';
      }

      debugPrint('DEBUG res $data');
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('hello');
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder:(context,snapshot) {
          return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Card(
                  color: const Color(0xff99F6EC),
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2,
                        sigmaY: 2,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "300k",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              Icons.cloud,
                              color: Colors.white,
                              size: 68,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Rain',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Weather Forecast',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecastItem(
                      time: '00:00',
                      icon: Icons.cloud,
                      temperature: '301.22',
                    ),
                    HourlyForecastItem(
                      time: '03:00',
                      icon: Icons.sunny,
                      temperature: '375.10',
                    ),
                    HourlyForecastItem(
                      time: '06:00',
                      icon: Icons.cloud,
                      temperature: '301.22',
                    ),
                    HourlyForecastItem(
                      time: '06:00',
                      icon: Icons.sunny,
                      temperature: '349.22',
                    ),
                    HourlyForecastItem(
                      time: '02:00',
                      icon: Icons.cloud,
                      temperature: '301.22',
                    ),
                    HourlyForecastItem(
                      time: '06:00',
                      icon: Icons.cloudy_snowing,
                      temperature: '10.22',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(
                    icon: Icons.water_drop,
                    label: 'Humadity',
                    value: '91',
                  ),
                  AdditionalInfoItem(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: '7.5',
                  ),
                  AdditionalInfoItem(
                    icon: Icons.beach_access,
                    label: 'Pressure',
                    value: '1000',
                  ),
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}
/**
 * API results call
  {
"cod": "200",
"message": 0,
"cnt": 40,
"list": [
{
"dt": 1693245600,
"main": {
"temp": 292.59,
"feels_like": 291.97,
"temp_min": 291.14,
"temp_max": 292.59,
"pressure": 1013,
"sea_level": 1013,
"grnd_level": 1012,
"humidity": 53,
"temp_kf": 1.45
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 90
},
"wind": {
"speed": 3.91,
"deg": 307,
"gust": 4.88
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-28 18:00:00"
},
{
"dt": 1693256400,
"main": {
"temp": 291.02,
"feels_like": 290.3,
"temp_min": 289.87,
"temp_max": 291.02,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1012,
"humidity": 55,
"temp_kf": 1.15
},
"weather": [
{
"id": 803,
"main": "Clouds",
"description": "broken clouds",
"icon": "04n"
}
],
"clouds": {
"all": 57
},
"wind": {
"speed": 1.92,
"deg": 297,
"gust": 4.08
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-28 21:00:00"
},
{
"dt": 1693267200,
"main": {
"temp": 288.83,
"feels_like": 288.12,
"temp_min": 288.83,
"temp_max": 288.83,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1011,
"humidity": 64,
"temp_kf": 0
},
"weather": [
{
"id": 803,
"main": "Clouds",
"description": "broken clouds",
"icon": "04n"
}
],
"clouds": {
"all": 57
},
"wind": {
"speed": 2.39,
"deg": 330,
"gust": 5.78
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-29 00:00:00"
},
{
"dt": 1693278000,
"main": {
"temp": 286.99,
"feels_like": 286.26,
"temp_min": 286.99,
"temp_max": 286.99,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1011,
"humidity": 70,
"temp_kf": 0
},
"weather": [
{
"id": 803,
"main": "Clouds",
"description": "broken clouds",
"icon": "04n"
}
],
"clouds": {
"all": 60
},
"wind": {
"speed": 1.52,
"deg": 302,
"gust": 3.78
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-29 03:00:00"
},
{
"dt": 1693288800,
"main": {
"temp": 286.43,
"feels_like": 285.67,
"temp_min": 286.43,
"temp_max": 286.43,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1011,
"humidity": 71,
"temp_kf": 0
},
"weather": [
{
"id": 802,
"main": "Clouds",
"description": "scattered clouds",
"icon": "03d"
}
],
"clouds": {
"all": 33
},
"wind": {
"speed": 1.66,
"deg": 280,
"gust": 3.72
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-29 06:00:00"
},
{
"dt": 1693299600,
"main": {
"temp": 290.46,
"feels_like": 289.71,
"temp_min": 290.46,
"temp_max": 290.46,
"pressure": 1013,
"sea_level": 1013,
"grnd_level": 1010,
"humidity": 56,
"temp_kf": 0
},
"weather": [
{
"id": 800,
"main": "Clear",
"description": "clear sky",
"icon": "01d"
}
],
"clouds": {
"all": 0
},
"wind": {
"speed": 2.47,
"deg": 273,
"gust": 3.53
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-29 09:00:00"
},
{
"dt": 1693310400,
"main": {
"temp": 294.09,
"feels_like": 293.41,
"temp_min": 294.09,
"temp_max": 294.09,
"pressure": 1011,
"sea_level": 1011,
"grnd_level": 1008,
"humidity": 45,
"temp_kf": 0
},
"weather": [
{
"id": 800,
"main": "Clear",
"description": "clear sky",
"icon": "01d"
}
],
"clouds": {
"all": 4
},
"wind": {
"speed": 2.57,
"deg": 263,
"gust": 3.58
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-29 12:00:00"
},
{
"dt": 1693321200,
"main": {
"temp": 293.71,
"feels_like": 293.13,
"temp_min": 293.71,
"temp_max": 293.71,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 50,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 91
},
"wind": {
"speed": 3.31,
"deg": 253,
"gust": 4.54
},
"visibility": 10000,
"pop": 0.1,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-29 15:00:00"
},
{
"dt": 1693332000,
"main": {
"temp": 291.85,
"feels_like": 291.53,
"temp_min": 291.85,
"temp_max": 291.85,
"pressure": 1009,
"sea_level": 1009,
"grnd_level": 1006,
"humidity": 67,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10d"
}
],
"clouds": {
"all": 92
},
"wind": {
"speed": 2.84,
"deg": 272,
"gust": 6.09
},
"visibility": 10000,
"pop": 0.67,
"rain": {
"3h": 0.77
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-29 18:00:00"
},
{
"dt": 1693342800,
"main": {
"temp": 289.55,
"feels_like": 289.36,
"temp_min": 289.55,
"temp_max": 289.55,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1006,
"humidity": 81,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10n"
}
],
"clouds": {
"all": 46
},
"wind": {
"speed": 2.73,
"deg": 279,
"gust": 6.63
},
"visibility": 10000,
"pop": 0.62,
"rain": {
"3h": 0.72
},
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-29 21:00:00"
},
{
"dt": 1693353600,
"main": {
"temp": 287.33,
"feels_like": 286.63,
"temp_min": 287.33,
"temp_max": 287.33,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 70,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10n"
}
],
"clouds": {
"all": 65
},
"wind": {
"speed": 2.99,
"deg": 323,
"gust": 7.74
},
"visibility": 10000,
"pop": 0.48,
"rain": {
"3h": 0.3
},
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-30 00:00:00"
},
{
"dt": 1693364400,
"main": {
"temp": 285.42,
"feels_like": 284.66,
"temp_min": 285.42,
"temp_max": 285.42,
"pressure": 1009,
"sea_level": 1009,
"grnd_level": 1006,
"humidity": 75,
"temp_kf": 0
},
"weather": [
{
"id": 802,
"main": "Clouds",
"description": "scattered clouds",
"icon": "03n"
}
],
"clouds": {
"all": 32
},
"wind": {
"speed": 2.56,
"deg": 304,
"gust": 7.18
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-30 03:00:00"
},
{
"dt": 1693375200,
"main": {
"temp": 284.85,
"feels_like": 284.03,
"temp_min": 284.85,
"temp_max": 284.85,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1006,
"humidity": 75,
"temp_kf": 0
},
"weather": [
{
"id": 801,
"main": "Clouds",
"description": "few clouds",
"icon": "02d"
}
],
"clouds": {
"all": 16
},
"wind": {
"speed": 2.43,
"deg": 285,
"gust": 6.43
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-30 06:00:00"
},
{
"dt": 1693386000,
"main": {
"temp": 288.76,
"feels_like": 287.94,
"temp_min": 288.76,
"temp_max": 288.76,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 60,
"temp_kf": 0
},
"weather": [
{
"id": 800,
"main": "Clear",
"description": "clear sky",
"icon": "01d"
}
],
"clouds": {
"all": 0
},
"wind": {
"speed": 3.27,
"deg": 288,
"gust": 4.72
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-30 09:00:00"
},
{
"dt": 1693396800,
"main": {
"temp": 291.76,
"feels_like": 290.9,
"temp_min": 291.76,
"temp_max": 291.76,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 47,
"temp_kf": 0
},
"weather": [
{
"id": 801,
"main": "Clouds",
"description": "few clouds",
"icon": "02d"
}
],
"clouds": {
"all": 20
},
"wind": {
"speed": 4.05,
"deg": 285,
"gust": 5.34
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-30 12:00:00"
},
{
"dt": 1693407600,
"main": {
"temp": 290.73,
"feels_like": 289.9,
"temp_min": 290.73,
"temp_max": 290.73,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 52,
"temp_kf": 0
},
"weather": [
{
"id": 803,
"main": "Clouds",
"description": "broken clouds",
"icon": "04d"
}
],
"clouds": {
"all": 72
},
"wind": {
"speed": 4.52,
"deg": 295,
"gust": 6.42
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-30 15:00:00"
},
{
"dt": 1693418400,
"main": {
"temp": 290.05,
"feels_like": 289.18,
"temp_min": 290.05,
"temp_max": 290.05,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 53,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 86
},
"wind": {
"speed": 3.63,
"deg": 295,
"gust": 5.26
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-30 18:00:00"
},
{
"dt": 1693429200,
"main": {
"temp": 288.24,
"feels_like": 287.5,
"temp_min": 288.24,
"temp_max": 288.24,
"pressure": 1011,
"sea_level": 1011,
"grnd_level": 1007,
"humidity": 65,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04n"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 2.22,
"deg": 257,
"gust": 5.94
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-30 21:00:00"
},
{
"dt": 1693440000,
"main": {
"temp": 287.18,
"feels_like": 286.54,
"temp_min": 287.18,
"temp_max": 287.18,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 73,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04n"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 2.31,
"deg": 263,
"gust": 6.03
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-31 00:00:00"
},
{
"dt": 1693450800,
"main": {
"temp": 287.07,
"feels_like": 286.42,
"temp_min": 287.07,
"temp_max": 287.07,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 73,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04n"
}
],
"clouds": {
"all": 97
},
"wind": {
"speed": 2.21,
"deg": 239,
"gust": 4.38
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-31 03:00:00"
},
{
"dt": 1693461600,
"main": {
"temp": 287.13,
"feels_like": 286.41,
"temp_min": 287.13,
"temp_max": 287.13,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 70,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 99
},
"wind": {
"speed": 2.09,
"deg": 223,
"gust": 5.06
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-31 06:00:00"
},
{
"dt": 1693472400,
"main": {
"temp": 288.62,
"feels_like": 287.97,
"temp_min": 288.62,
"temp_max": 288.62,
"pressure": 1011,
"sea_level": 1011,
"grnd_level": 1008,
"humidity": 67,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 3.11,
"deg": 199,
"gust": 7.22
},
"visibility": 10000,
"pop": 0.16,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-31 09:00:00"
},
{
"dt": 1693483200,
"main": {
"temp": 289.81,
"feels_like": 289.62,
"temp_min": 289.81,
"temp_max": 289.81,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 80,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 4.26,
"deg": 176,
"gust": 7.9
},
"visibility": 10000,
"pop": 0.33,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-31 12:00:00"
},
{
"dt": 1693494000,
"main": {
"temp": 290.07,
"feels_like": 290.09,
"temp_min": 290.07,
"temp_max": 290.07,
"pressure": 1009,
"sea_level": 1009,
"grnd_level": 1006,
"humidity": 87,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 98
},
"wind": {
"speed": 4.14,
"deg": 170,
"gust": 9.54
},
"visibility": 10000,
"pop": 0.16,
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-31 15:00:00"
},
{
"dt": 1693504800,
"main": {
"temp": 290.23,
"feels_like": 290.5,
"temp_min": 290.23,
"temp_max": 290.23,
"pressure": 1009,
"sea_level": 1009,
"grnd_level": 1006,
"humidity": 96,
"temp_kf": 0
},
"weather": [
{
"id": 501,
"main": "Rain",
"description": "moderate rain",
"icon": "10d"
}
],
"clouds": {
"all": 99
},
"wind": {
"speed": 1.75,
"deg": 279,
"gust": 5.28
},
"visibility": 4302,
"pop": 0.9,
"rain": {
"3h": 9.5
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-08-31 18:00:00"
},
{
"dt": 1693515600,
"main": {
"temp": 290.05,
"feels_like": 290.3,
"temp_min": 290.05,
"temp_max": 290.05,
"pressure": 1010,
"sea_level": 1010,
"grnd_level": 1007,
"humidity": 96,
"temp_kf": 0
},
"weather": [
{
"id": 501,
"main": "Rain",
"description": "moderate rain",
"icon": "10n"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 2.63,
"deg": 223,
"gust": 7.81
},
"visibility": 10000,
"pop": 0.79,
"rain": {
"3h": 5.46
},
"sys": {
"pod": "n"
},
"dt_txt": "2023-08-31 21:00:00"
},
{
"dt": 1693526400,
"main": {
"temp": 289.22,
"feels_like": 289.42,
"temp_min": 289.22,
"temp_max": 289.22,
"pressure": 1011,
"sea_level": 1011,
"grnd_level": 1008,
"humidity": 97,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10n"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 2.77,
"deg": 232,
"gust": 7.75
},
"visibility": 10000,
"pop": 0.58,
"rain": {
"3h": 0.4
},
"sys": {
"pod": "n"
},
"dt_txt": "2023-09-01 00:00:00"
},
{
"dt": 1693537200,
"main": {
"temp": 288.54,
"feels_like": 288.64,
"temp_min": 288.54,
"temp_max": 288.54,
"pressure": 1011,
"sea_level": 1011,
"grnd_level": 1008,
"humidity": 96,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04n"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 1.53,
"deg": 241,
"gust": 3.88
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-09-01 03:00:00"
},
{
"dt": 1693548000,
"main": {
"temp": 288.45,
"feels_like": 288.49,
"temp_min": 288.45,
"temp_max": 288.45,
"pressure": 1012,
"sea_level": 1012,
"grnd_level": 1009,
"humidity": 94,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 1.71,
"deg": 225,
"gust": 5.35
},
"visibility": 10000,
"pop": 0.06,
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-01 06:00:00"
},
{
"dt": 1693558800,
"main": {
"temp": 289.35,
"feels_like": 289.32,
"temp_min": 289.35,
"temp_max": 289.35,
"pressure": 1013,
"sea_level": 1013,
"grnd_level": 1010,
"humidity": 88,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 1.32,
"deg": 230,
"gust": 3.01
},
"visibility": 10000,
"pop": 0.26,
"rain": {
"3h": 0.18
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-01 09:00:00"
},
{
"dt": 1693569600,
"main": {
"temp": 290.02,
"feels_like": 289.96,
"temp_min": 290.02,
"temp_max": 290.02,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1010,
"humidity": 84,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 2.23,
"deg": 182,
"gust": 2.73
},
"visibility": 10000,
"pop": 0.51,
"rain": {
"3h": 0.75
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-01 12:00:00"
},
{
"dt": 1693580400,
"main": {
"temp": 289.52,
"feels_like": 289.51,
"temp_min": 289.52,
"temp_max": 289.52,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1011,
"humidity": 88,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 1.18,
"deg": 165,
"gust": 1.71
},
"visibility": 10000,
"pop": 0.61,
"rain": {
"3h": 0.69
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-01 15:00:00"
},
{
"dt": 1693591200,
"main": {
"temp": 290.13,
"feels_like": 290.1,
"temp_min": 290.13,
"temp_max": 290.13,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1011,
"humidity": 85,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 97
},
"wind": {
"speed": 0.53,
"deg": 128,
"gust": 0.76
},
"visibility": 10000,
"pop": 0.42,
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-01 18:00:00"
},
{
"dt": 1693602000,
"main": {
"temp": 288.97,
"feels_like": 289.01,
"temp_min": 288.97,
"temp_max": 288.97,
"pressure": 1015,
"sea_level": 1015,
"grnd_level": 1012,
"humidity": 92,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04n"
}
],
"clouds": {
"all": 95
},
"wind": {
"speed": 1.17,
"deg": 69,
"gust": 1.38
},
"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2023-09-01 21:00:00"
},
{
"dt": 1693612800,
"main": {
"temp": 288.47,
"feels_like": 288.54,
"temp_min": 288.47,
"temp_max": 288.47,
"pressure": 1015,
"sea_level": 1015,
"grnd_level": 1012,
"humidity": 95,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04n"
}
],
"clouds": {
"all": 97
},
"wind": {
"speed": 1.88,
"deg": 68,
"gust": 4.94
},
"visibility": 10000,
"pop": 0.02,
"sys": {
"pod": "n"
},
"dt_txt": "2023-09-02 00:00:00"
},
{
"dt": 1693623600,
"main": {
"temp": 288.28,
"feels_like": 288.43,
"temp_min": 288.28,
"temp_max": 288.28,
"pressure": 1015,
"sea_level": 1015,
"grnd_level": 1011,
"humidity": 99,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04n"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 1.93,
"deg": 70,
"gust": 6.41
},
"visibility": 10000,
"pop": 0.37,
"sys": {
"pod": "n"
},
"dt_txt": "2023-09-02 03:00:00"
},
{
"dt": 1693634400,
"main": {
"temp": 289.01,
"feels_like": 289.24,
"temp_min": 289.01,
"temp_max": 289.01,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1011,
"humidity": 99,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10d"
}
],
"clouds": {
"all": 99
},
"wind": {
"speed": 2.89,
"deg": 54,
"gust": 7.57
},
"visibility": 10000,
"pop": 0.57,
"rain": {
"3h": 1.1
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-02 06:00:00"
},
{
"dt": 1693645200,
"main": {
"temp": 291.97,
"feels_like": 292.15,
"temp_min": 291.97,
"temp_max": 291.97,
"pressure": 1015,
"sea_level": 1015,
"grnd_level": 1012,
"humidity": 86,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 4.8,
"deg": 69,
"gust": 9.21
},
"visibility": 10000,
"pop": 0.52,
"rain": {
"3h": 0.55
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-02 09:00:00"
},
{
"dt": 1693656000,
"main": {
"temp": 292.7,
"feels_like": 292.85,
"temp_min": 292.7,
"temp_max": 292.7,
"pressure": 1015,
"sea_level": 1015,
"grnd_level": 1011,
"humidity": 82,
"temp_kf": 0
},
"weather": [
{
"id": 804,
"main": "Clouds",
"description": "overcast clouds",
"icon": "04d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 5.25,
"deg": 84,
"gust": 10.01
},
"visibility": 10000,
"pop": 0.4,
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-02 12:00:00"
},
{
"dt": 1693666800,
"main": {
"temp": 292.12,
"feels_like": 292.29,
"temp_min": 292.12,
"temp_max": 292.12,
"pressure": 1014,
"sea_level": 1014,
"grnd_level": 1011,
"humidity": 85,
"temp_kf": 0
},
"weather": [
{
"id": 500,
"main": "Rain",
"description": "light rain",
"icon": "10d"
}
],
"clouds": {
"all": 100
},
"wind": {
"speed": 4.35,
"deg": 86,
"gust": 8.19
},
"visibility": 10000,
"pop": 0.32,
"rain": {
"3h": 0.13
},
"sys": {
"pod": "d"
},
"dt_txt": "2023-09-02 15:00:00"
}
],
"city": {
"id": 2643743,
"name": "London",
"coord": {
"lat": 51.5085,
"lon": -0.1257
},
"country": "GB",
"population": 1000000,
"timezone": 3600,
"sunrise": 1693199174,
"sunset": 1693249077
}
}
 */