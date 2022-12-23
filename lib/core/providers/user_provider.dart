import 'package:flutter/cupertino.dart';
import 'package:myfeed/screens/home/domain/model/user.dart';
import 'package:myfeed/screens/home/domain/repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User get getUser => _user!;

  Future<void> refreshUser() async {
    _user = await UserRepository().getProfileUser();
    notifyListeners();
  }
}
