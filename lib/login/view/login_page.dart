import 'package:admin/authentication/authentication.dart';
import 'package:admin/login/regex/regex.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  static final FormFieldValidator<String> usernameValidator = (value) {
    if (value!.isEmpty || !Regex.username.hasMatch(value)) {
      return 'Tên đăng nhập không hợp lệ';
    }
    return null;
  };

  static final FormFieldValidator<String> passwordValidator = (value) {
    if (value!.isEmpty || value.length <= 2) {
      return 'Mật khẩu quá ngắn';
    }
    return null;
  };

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);
  late BuildContext _context;
  late AuthenticationStatus _authenticationStatus;

  Future<String> _authUser(LoginData data) async {
    if (data.password != '1234') {
      return 'Tên đăng nhập hoặc mật khẩu không trùng khớp';
    }
    _authenticationStatus =
        await RepositoryProvider.of<AuthenticationRepository>(_context)
            .logIn(username: data.name, password: data.password);
    Future.delayed(
        const Duration(milliseconds: 1000),
        () => _context
            .read<AuthenticationBloc>()
            .add(AuthenticationStatusChanged(_authenticationStatus)));
    return '';
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return 'Tên đăng nhập không tồn tại';
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Theme(
        data: ThemeData.light(),
        child: FlutterLogin(
          title: 'eShop',
          onLogin: _authUser,
          onSignup: _authUser,
          userValidator: LoginPage.usernameValidator,
          passwordValidator: LoginPage.passwordValidator,
          messages: LoginMessages(
            userHint: 'Tên đăng nhập',
            passwordHint: 'Mật khẩu',
            confirmPasswordHint: 'Xác nhận mật khẩu',
            confirmPasswordError: 'Mật khẩu xác nhận không trùng khớp',
            flushbarTitleError: 'Đăng nhập không thành công',
            flushbarTitleSuccess: 'Đặng nhập thành công',
            providersTitle: '',
            recoverPasswordButton: 'Khôi phục mật khẩu',
            recoverPasswordDescription:
                'Bạn quên mật khẩu ư? Kệ cha bạn, chúng tôi chưa hỗ trợ tính năng phục hồi mật khẩu',
            recoverPasswordIntro: 'Có cái mật khẩu mà cũng để bị quên',
            recoverPasswordSuccess: 'Phục hồi mật khẩu xong rồi nhé',
            signupButton: 'Đăng ký',
            signUpSuccess: 'Đăng ký thành công!',
            forgotPasswordButton: 'Quên mật khẩu',
            loginButton: 'Đăng nhập',
            goBackButton: 'Trở về',
          ),
          userType: LoginUserType.name,
          onRecoverPassword: _recoverPassword,
        ));
  }
}
