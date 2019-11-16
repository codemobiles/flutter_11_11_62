import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CountState extends Equatable {
  const CountState();

  @override
  List<Object> get props => [];
}

class InitialCountState extends CountState {}

class LoadedAddState extends CountState{
  final int count;

  const LoadedAddState({this.count});

  @override
  // TODO: implement props
  List<Object> get props => [count];


  @override
  String toString() => "CountAddState: count = $count";
}
