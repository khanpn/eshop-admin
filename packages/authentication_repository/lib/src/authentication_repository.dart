import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

class AuthenticationRepository {
  final UserRepository _userRepository;

  AuthenticationRepository({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<AuthenticationStatus> logIn({
    required String username,
    required String password,
  }) async {
    User? user = await _userRepository.getUser(username);
    if (user != null) {
      _userRepository.loggedUser = user;
      return AuthenticationStatus.authenticated;
    }
    return AuthenticationStatus.unauthenticated;
  }

  Future<bool> logOut() {
    _userRepository.loggedUser = null;
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => true,
    );
  }
}
