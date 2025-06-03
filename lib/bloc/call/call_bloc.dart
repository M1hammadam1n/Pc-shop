import 'package:flutter_bloc/flutter_bloc.dart';
import 'call_event.dart';
import 'call_state.dart';
import 'package:url_launcher/url_launcher.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc() : super(CallInitial()) {
    on<MakePhoneCall>(_onMakePhoneCall);
  }

  Future<void> _onMakePhoneCall(
      MakePhoneCall event, Emitter<CallState> emit) async {
    emit(CallInProgress());
    final Uri phoneUri = Uri(scheme: 'tel', path: event.phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
        emit(CallSuccess());
      } else {
        emit(CallFailure('Не удалось открыть телефонное приложение'));
      }
    } catch (e) {
      emit(CallFailure('Произошла ошибка: ${e.toString()}'));
    }
  }
}
