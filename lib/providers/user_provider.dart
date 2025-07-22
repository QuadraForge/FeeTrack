import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier{
  final List<UserModel> _users = [];

  List<UserModel> get users => _users;

  void addUser(UserModel user){
    _users.add(user);
    notifyListeners();
  }

  void removeUser(int index){
    _users.removeAt(index);
    notifyListeners();
  }
}