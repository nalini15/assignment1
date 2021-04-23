import 'package:assignment1/model/basicModel.dart';
import 'package:flutter/material.dart';

class BasicViewModel with ChangeNotifier {
  // male female
  bool isMale = false;
  bool showPassword = false;

  BasicModel _basicModel;

  void loadData(Map<String, dynamic> data) {
    _basicModel = BasicModel.fromJson(data);
    notifyListeners();
  }

  void changeUserGender(bool val) {
    isMale = val;
    notifyListeners();
  }

  void changePassVisi(bool val) {
    showPassword = !val;
    notifyListeners();
  }

  String get email {
    return _basicModel?.email ?? "";
  }

  String get fname {
    return _basicModel?.fname ?? "";
  }

  String get lname {
    return _basicModel?.lname ?? "";
  }

  String get contact {
    return _basicModel?.contact ?? "";
  }

  bool get gender {
    isMale = _basicModel?.isMale ?? false;
    return _basicModel?.isMale ?? false;
  }

  String get password {
    return _basicModel?.password ?? "";
  }
}
