import 'package:flutter_login_register/data/rest_data.dart';
import 'package:flutter_login_register/models/user.dart';

abstract class RegisterPageContract {
  void onRegisterSuccess(User user);
  void onRegisterError(String error);
}

class RegisterPagePresenter {
  RegisterPageContract _view;
  RestData api = new RestData();
  RegisterPagePresenter(this._view);

  doRegister(String username, String password) {
    //print("HI");
    api
        .login(username, password)
        .then((user) => _view.onRegisterSuccess(user))
        .catchError((onError) {
          //print("Trying to Catch"+onError.toString());
          return _view.onRegisterError(onError.toString());
    });
  }
}