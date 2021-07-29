import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/bloc/counter/counter_bloc.dart';
import 'package:learn_bloc/constants/general.dart';

class HomeScreen extends StatelessWidget implements CounterSaveDelegate {
  late final BuildContext _context;
  @override
  void onError(String message) {
    _showAlertSnackbar(message);
  }

  @override
  void onSuccess(String message) {
    _showAlertSnackbar(message);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(LoadCounter());
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(SaveCounter(this));
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        bloc: BlocProvider.of<CounterBloc>(context),
        builder: (_, state) {
          if (state is CounterInitial || state is CounterSave) {
            BlocProvider.of<CounterBloc>(context).add(LoadCounter());
            return SizedBox();
          } else if (state is CounterLoaded) {
            return Center(
              child: Text(
                '${state.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          } else if (state is CounterError) {
            return Center(
              child: Text(
                '${state.error}',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(IncrementCounter(1));
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(ResetCounter());
            },
            child: Icon(Icons.restore),
          ),
        ],
      ),
    );
  }

  void _showAlertSnackbar(String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }
}
