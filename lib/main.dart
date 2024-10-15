import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/provider/weather_provider.dart';
import 'screens/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Weather Forecast',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WeatherApp(),
      ),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  bool showSplash = true;

  @override
  void initState() {
    super.initState();
   
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showSplash = false; 
      });
    });
    Provider.of<WeatherProvider>(context, listen: false).loadLastCity();
  }

  @override
  Widget build(BuildContext context) {
    return showSplash ? SplashScreen() : const WeatherScreen();
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), 
      body: Center(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: <Color>[
                Color(0xFFFFA500),
                Colors.white,      
                Color(0xFFFFA500), 
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'Weather\nForecast',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
        ),
      ),
    );
  }
}
