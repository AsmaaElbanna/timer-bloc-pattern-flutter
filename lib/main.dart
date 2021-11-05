import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_project/bloc/timer_bloc.dart';
import 'package:timer_project/ticker.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF96C7F3),
      ),
      home: BlocProvider(
        create: (context) => TimerBloc(ticker: Ticker()),
        child: HomeScreen(),
      ),
    );
  }
}
