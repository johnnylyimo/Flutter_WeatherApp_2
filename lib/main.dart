import 'package:flutter/material.dart';
import 'package:weather_app2/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:
          'Weather App', // for IOS title is mention in info.plist in ios/runner > press command + p (open searchbar) type info.plist
      theme: ThemeData(
        //   theme: ThemeData.dark/light(useMaterial3: true)
        // This is the theme of your application.
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // Teal Color for seedColor & inversePrimary > #14b8a6
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff14b8a6),
          primary: const Color(0xff14b8a6),
          onPrimary: const Color(0xffccfbf1),
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
