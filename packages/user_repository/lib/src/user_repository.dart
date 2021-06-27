import 'dart:async';
import 'package:uuid/uuid.dart';
part 'model/user.dart';

class UserRepository {

  User? _loggedUser;

  Future<User?> getUser(String username) async {
    User user = User();
    user.id = const Uuid().v4();
    user.username = username;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => user,
    );
  }

  set loggedUser(User? value) {
    _loggedUser = value;
  }

  User? get loggedUser => _loggedUser;
}
