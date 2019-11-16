import 'package:meta/meta.dart';

@immutable
abstract class CountEvent {}


class AddEvent extends CountEvent{}

class ResetEvent extends CountEvent{}