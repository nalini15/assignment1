import 'package:assignment1/model/addressModel.dart';
import 'package:flutter/material.dart';

class AddressViewModel with ChangeNotifier {
  AddressModel _addressModel;
  String selectedState;

  void changeState(String value) {
    selectedState = value;
    notifyListeners();
  }

  void loadData(Map<String, dynamic> data) {
    _addressModel = AddressModel.fromJson(data);
    notifyListeners();
  }

  String get address {
    return _addressModel?.address ?? "";
  }

  String get landmark {
    return _addressModel?.landmark ?? "";
  }

  String get city {
    return _addressModel?.city ?? "";
  }

  String get state {
    return _addressModel?.state ?? "";
  }

  String get pinCode {
    return _addressModel?.pinCode ?? "";
  }
}
