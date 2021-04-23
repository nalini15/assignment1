import 'package:assignment1/model/profModel.dart';
import 'package:flutter/material.dart';

class ProfViewModel with ChangeNotifier {
  ProfModel _profModel;
  Map<String, dynamic> formData = {
    "education": null,
    "passing": null,
    "grade": "",
    "exp": "",
    "design": null,
    "domain": null,
  };

  void addData() {
    _profModel = ProfModel.fromJson(formData);
  }

  bool validateDropDown() {
    return formData.containsValue(null);
  }

  void reloadFormData() {
    notifyListeners();
  }

  String get exp {
    return _profModel?.experience ?? "";
  }

  String get grade {
    return _profModel?.grade ?? "";
  }
}
