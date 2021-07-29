import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/bloc/counter/counter_bloc.dart';
import 'package:learn_bloc/constants/general.dart';
import 'package:learn_bloc/screen/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: HomeScreen(),
      ),
    );
  }
}
