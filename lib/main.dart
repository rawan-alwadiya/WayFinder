import 'package:flutter/material.dart';
import 'package:maps/screens/map_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/map_screen',
      routes: {
        '/map_screen': (context) => const MapScreen(),
      },
    );
  }
}
