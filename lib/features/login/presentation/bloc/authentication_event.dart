part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  final List<Object> properties;
  const AuthenticationEvent(this.properties);

  @override
  List<Object> get props => properties;
}

class InitialAuthCheckEvent extends AuthenticationEvent {
  InitialAuthCheckEvent() : super([]);
}

class LoginRequestEvent extends AuthenticationEvent {
  final Usertype type;
  LoginRequestEvent(this.type) : super([type]);
}

class LoginEvent extends AuthenticationEvent {
  final Usertype type;
  LoginEvent(this.type) : super([type]);
}

class LogoutEvent extends AuthenticationEvent {
  LogoutEvent() : super([]);
}
