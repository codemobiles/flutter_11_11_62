import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class CountBloc extends Bloc<CountEvent, CountState> {
  int count = 0;

  @override
  CountState get initialState => InitialCountState();

  @override
  Stream<CountState> mapEventToState(CountEvent event) async* {
    if (event is AddEvent) {
      yield LoadedAddState(count: ++count);
    }

    if(event is ResetEvent){
      yield LoadedAddState(count: 0);
    }
  }
}
