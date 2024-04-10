part of 'transition_bloc.dart';

abstract class TransitionState extends Equatable {}

class TransitionInitialState extends TransitionState {
  TransitionInitialState();

  @override
  List<Object> get props => [];
}

class TransitionLoadingState extends TransitionState {
  TransitionLoadingState();

  @override
  List<Object> get props => [];
}

class TransitionSplashState extends TransitionState {
  TransitionSplashState();

  @override
  List<Object> get props => [];
}

class TransitionSignInState extends TransitionState {
  TransitionSignInState();

  @override
  List<Object> get props => [];
}

class TransitionSignUpState extends TransitionState {
  TransitionSignUpState();

  @override
  List<Object> get props => [];
}

class TransitionSignUpPasswordState extends TransitionState {
  TransitionSignUpPasswordState();

  @override
  List<Object> get props => [];
}

class TransitionHomeState extends TransitionState {
  TransitionHomeState();

  @override
  List<Object> get props => [];
}

class TransitionPermissionState extends TransitionState {
  TransitionPermissionState();

  @override
  List<Object> get props => [];
}

class TransitionAuthSMSState extends TransitionState {
  TransitionAuthSMSState();

  @override
  List<Object> get props => [];
}

class TransitionTermsState extends TransitionState {
  TransitionTermsState();

  @override
  List<Object> get props => [];
}

class TransitionErrState extends TransitionState {
  TransitionErrState();

  @override
  List<Object> get props => [];
}
