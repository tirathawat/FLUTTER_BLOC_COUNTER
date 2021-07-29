import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/bloc/flow_bloc_observer.dart';
import 'config/app.dart';

void main() {
  Bloc.observer = FlowBlocObserver();
  runApp(App());
}
