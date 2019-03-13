import 'package:flutter_login_register/data/rest_data.dart';
import 'package:flutter_login_register/models/user.dart';
import 'package:flutter_login_register/data/database_helper.dart';
abstract class LoginPageContract {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  RestData api = new RestData();
  LoginPagePresenter(this._view);

  doLogin(String username, String password) {
    //print("HI");
    var db = new DatabaseHelper();
    db.checkUser(User(username,password)).
        then((user) => _view.onLoginSuccess(user))
        .catchError((onError) {
          //print("Trying to Catch"+onError.toString());
          return _view.onLoginError(onError.toString());
        });

  }
}
