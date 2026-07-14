import '../services/auth_service.dart';

import '../state/login_state.dart';

class LoginController {

  final AuthService authService;

  LoginController(this.authService);

  Future<LoginState> login(

  String email,

  String password,
) async {

  final data =
      await AuthService.login(

    email,

    password,
  );

  if (data != null) {

    return LoginState(

      isSuccess: true,

      message:
          data["role"],
    );
  }

  return LoginState(

    isSuccess: false,

    message:
        "Email ou mot de passe incorrect",
  );
}
}