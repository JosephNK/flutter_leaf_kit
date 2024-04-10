library transition_blocs;

import 'dart:async';

import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_store/leaf_store.dart';

part 'transition_event.dart';
part 'transition_state.dart';

class TransitionBloc extends Bloc<TransitionEvent, TransitionState> {
  TransitionBloc() : super(TransitionSplashState()) {
    on<TransitionSplashEvent>(
      (event, emit) => _mapSplashToState(event, emit),
    );
    on<TransitionSignInEvent>(
      (event, emit) => _mapSignInToState(event, emit),
    );
    on<TransitionSignUpEvent>(
      (event, emit) => _mapSignUpToState(event, emit),
    );
    on<TransitionSignUpPasswordEvent>(
      (event, emit) => _mapSignUpPasswordToState(event, emit),
    );
    on<TransitionHomeEvent>(
      (event, emit) => _mapHomeToState(event, emit),
    );
    on<TransitionPermissionEvent>(
      (event, emit) => _mapPermissionToState(event, emit),
    );
    on<TransitionAuthSMSEvent>(
      (event, emit) => _mapAuthSMSToState(event, emit),
    );
    on<TransitionTermsEvent>(
      (event, emit) => _mapTermsToState(event, emit),
    );
    on<TransitionErrEvent>(
      (event, emit) => _mapErrToState(event, emit),
    );
  }

  final duration = const Duration(milliseconds: 100);

  Future<void> _mapSplashToState(
    TransitionSplashEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionSplashState());
  }

  Future<void> _mapSignInToState(
    TransitionSignInEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionSignInState());
  }

  Future<void> _mapSignUpToState(
    TransitionSignUpEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionSignUpState());
  }

  Future<void> _mapSignUpPasswordToState(
    TransitionSignUpPasswordEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionSignUpPasswordState());
  }

  Future<void> _mapHomeToState(
    TransitionHomeEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionHomeState());
  }

  Future<void> _mapPermissionToState(
    TransitionPermissionEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionPermissionState());
  }

  Future<void> _mapAuthSMSToState(
    TransitionAuthSMSEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionAuthSMSState());
  }

  Future<void> _mapTermsToState(
    TransitionTermsEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionTermsState());
  }

  Future<void> _mapErrToState(
    TransitionErrEvent event,
    Emitter<TransitionState> emit,
  ) async {
    emit(TransitionLoadingState());
    await Future.delayed(duration);
    emit(TransitionErrState());
  }
}
