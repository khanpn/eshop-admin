import 'package:admin/app.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  final userRepository = UserRepository();
  final authenticationRepository =
      AuthenticationRepository(userRepository: userRepository);
  runApp(
    App(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
    ),
  );
}
