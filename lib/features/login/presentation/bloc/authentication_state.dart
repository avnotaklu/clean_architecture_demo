part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final List<Object> _props;
  const AuthenticationState._(this._props);

  @override
  List<Object> get props => _props;
}

class AuthenticationInitialState extends AuthenticationState {
  AuthenticationInitialState() : super._([]);
}

class UnAuthorizedState extends AuthenticationState {
  final String error;
  UnAuthorizedState(this.error) : super._([error]);
}

class AuthorizedState extends AuthenticationState {
  final AuthUser user;
  AuthorizedState(this.user) : super._([user]);
}

class LoginProgressState extends AuthenticationState {
  LoginProgressState() : super._([]);
}

class AuthorizationPromptState extends AuthenticationState {
  AuthorizationPromptState() : super._([]);
}

class LogoutState extends AuthenticationState {
  LogoutState() : super._([]);
}
