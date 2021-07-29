part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {
  @override
  String toString() => "CounterInitial{}";
}

class CounterLoading extends CounterState {
  @override
  String toString() => "CounterLoading{}";
}

class CounterLoaded extends CounterState {
  final int count;

  CounterLoaded(this.count);
  @override
  String toString() => "CounterLoaded{count: $count}";
}

class CounterError extends CounterState {
  final String error;

  CounterError(this.error);
  @override
  String toString() => "CounterError{error: $error}";
}

class CounterSave extends CounterState {
  final int count;

  CounterSave(this.count);

  String toString() => "CounterSave{count: $count}";
}
