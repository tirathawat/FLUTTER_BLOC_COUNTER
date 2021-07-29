part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

abstract class CounterSaveDelegate {
  void onSuccess(String message);
  void onError(String message);
}

class IncrementCounter extends CounterEvent {
  final int count;

  IncrementCounter(this.count);
  @override
  String toString() => "IncrementCounter{count: $count}";
}

class ResetCounter extends CounterEvent {
  @override
  String toString() => "ResetCounter{}";
}

class SaveCounter extends CounterEvent {
  final CounterSaveDelegate delegate;

  SaveCounter(this.delegate);
  @override
  String toString() => "SaveCounter{delegate: $delegate}";
}

class LoadCounter extends CounterEvent {
  @override
  String toString() => "LoadCounter{}";
}
