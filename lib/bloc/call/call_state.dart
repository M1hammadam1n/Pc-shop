import 'package:equatable/equatable.dart';

abstract class CallState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CallInitial extends CallState {}

class CallInProgress extends CallState {}

class CallSuccess extends CallState {}

class CallFailure extends CallState {
  final String message;

  CallFailure(this.message);

  @override
  List<Object?> get props => [message];
}
