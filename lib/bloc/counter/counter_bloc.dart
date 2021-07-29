import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/constants/preferences.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial());

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementCounter) {
      yield* _mapIncrementCounterToState(event);
    } else if (event is ResetCounter) {
      yield* _mapResetCounterToState();
    } else if (event is SaveCounter) {
      yield* _mapSaveCounterToState(event);
    } else if (event is LoadCounter) {
      yield* _mapLoadCounterToState();
    }
  }

  Stream<CounterState> _mapIncrementCounterToState(
    IncrementCounter event,
  ) async* {
    int eventCount = event.count;
    int currentCount = (state as CounterLoaded).count;
    yield CounterLoaded(eventCount + currentCount);
  }

  Stream<CounterState> _mapResetCounterToState() async* {
    yield CounterLoaded(0);
  }

  Stream<CounterState> _mapSaveCounterToState(SaveCounter event) async* {
    try {
      int currentCount = (state as CounterLoaded).count;
      yield CounterSave(currentCount);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt(PREF_COUNT, currentCount);
      event.delegate.onSuccess("save $currentCount successfully");
    } catch (e) {
      event.delegate.onError(e.toString());
    }
  }

  Stream<CounterState> _mapLoadCounterToState() async* {
    yield CounterLoading();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int count = prefs.getInt(PREF_COUNT) ?? 0;
      yield CounterLoaded(count);
    } catch (e) {
      yield CounterError(e.toString());
    }
  }
}
