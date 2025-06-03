import 'package:equatable/equatable.dart';

abstract class CallEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MakePhoneCall extends CallEvent {
  final String phoneNumber;

  MakePhoneCall(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}
