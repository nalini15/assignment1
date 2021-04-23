import 'dart:io';

import 'package:assignment1/functions/widgetFunction.dart';
import 'package:assignment1/model/addressModel.dart';

import 'package:assignment1/navigations/navigationAnimation.dart';
import 'package:assignment1/style/colors.dart';
import 'package:assignment1/viewmodel/addressViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddressInfo extends StatefulWidget {
  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    "address": "",
    "landmark": "",
    "city": "",
    "state": "",
    "pinCode": "",
  };

  void submitData(BuildContext context) {
    if (_formKey.currentState.validate()) {
      final add = Provider.of<AddressViewModel>(context, listen: false);
      if (add.selectedState == null) {
        showSnack(context, 'Please select State', _scaffoldkey);
      } else {
        _formKey.currentState.save();
        add.loadData(formData);
        showSnack(context, 'Data Added Successfully', _scaffoldkey);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Your Address',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          top: Platform.isIOS ? false : true,
          bottom: Platform.isIOS ? false : true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildSizedBoxHeight(30),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Consumer<AddressViewModel>(
                      builder: (context, add, _) => Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSizedBoxHeight(10),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: textColor)),
                                child: TextFormField(
                                    initialValue: add.address,
                                    autocorrect: true,
                                    style: TextStyle(fontSize: 15),
                                    validator: (value) {
                                      return value.length < 3
                                          ? 'Name must be greater than two characters'
                                          : null;
                                      // if (value.trimRight().trimLeft().isEmpty) {
                                      //   return 'Please enter your address';
                                      // }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      formData['address'] =
                                          value.trimLeft().trimRight();
                                    },
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          // color: whiteTextColor,
                                          ),
                                      hintText: 'Address',
                                      prefixIcon: Icon(Icons.business,
                                          color: buttonCOlor),
                                      hintStyle: TextStyle(color: textColor1),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 10.0, 15.0),
                                      isDense: true,
                                      // hintStyle:
                                      //     normalStyle.copyWith(color: Colors.white),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.white),
                                      // ),
                                      // focusedBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: whiteTextColor),
                                      // ),
                                    )),
                              ),
                              buildSizedBoxHeight(20),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: textColor)),
                                child: TextFormField(
                                    initialValue: add.landmark,
                                    autocorrect: true,
                                    style: TextStyle(fontSize: 15),
                                    validator: (value) {
                                      // if (value.trimRight().trimLeft().isEmpty) {
                                      //   return 'Please enter your landmark';
                                      // }
                                      return value.length < 3
                                          ? 'Name must be greater than two characters'
                                          : null;
                                      //  return null;
                                    },
                                    onSaved: (value) {
                                      formData['landmark'] =
                                          value.trimLeft().trimRight();
                                    },
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          // color: whiteTextColor,
                                          ),
                                      hintText: 'Landmark',
                                      prefixIcon: Icon(Icons.business,
                                          color: buttonCOlor),
                                      hintStyle: TextStyle(color: textColor1),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 10.0, 15.0),
                                      isDense: true,
                                      // hintStyle:
                                      //     normalStyle.copyWith(color: Colors.white),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.white),
                                      // ),
                                      // focusedBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: whiteTextColor),
                                      // ),
                                    )),
                              ),
                              buildSizedBoxHeight(20),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: textColor)),
                                child: TextFormField(
                                    initialValue: add.city,
                                    autocorrect: true,
                                    style: TextStyle(fontSize: 15),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]')),
                                    ],
                                    validator: (value) {
                                      if (value
                                          .trimRight()
                                          .trimLeft()
                                          .isEmpty) {
                                        return 'Please enter your city';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      formData['city'] =
                                          value.trimLeft().trimRight();
                                    },
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          // color: whiteTextColor,
                                          ),
                                      hintText: 'City',
                                      prefixIcon: Icon(Icons.business,
                                          color: buttonCOlor),
                                      hintStyle: TextStyle(color: textColor1),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 10.0, 15.0),
                                      isDense: true,
                                      // hintStyle:
                                      //     normalStyle.copyWith(color: Colors.white),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.white),
                                      // ),
                                      // focusedBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: whiteTextColor),
                                      // ),
                                    )),
                              ),
                              buildSizedBoxHeight(20),
                              Container(
                                  width: buildWidth(context) / 1.1,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  decoration: BoxDecoration(

                                      // color: Colors.cyan,
                                      border: Border.all()),
                                  child: DropdownButton<String>(
                                    items: <String>[
                                      'Maharashtra',
                                      'Gujarat',
                                      'Karnataka',
                                      '“Madhya Pradesh',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(value)),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    hint: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "${add?.selectedState ?? "select State"}",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    onChanged: (value) {
                                      add.changeState(value);
                                      formData['state'] = value;
                                    },
                                  )),
                              buildSizedBoxHeight(20),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: textColor)),
                                child: TextFormField(
                                    initialValue: add.pinCode,
                                    autocorrect: true,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    validator: (value) {
                                      if (value
                                          .trimRight()
                                          .trimLeft()
                                          .isEmpty) {
                                        return 'Please enter your pin code';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      formData['pinCode'] =
                                          value.trimLeft().trimRight();
                                    },
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          // color: whiteTextColor,
                                          ),
                                      hintText: 'Pin Code',
                                      prefixIcon: Icon(
                                        Icons.business,
                                        color: buttonCOlor,
                                      ),
                                      hintStyle: TextStyle(color: textColor1),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 10.0, 15.0),
                                      isDense: true,
                                      // hintStyle:
                                      //     normalStyle.copyWith(color: Colors.white),
                                      // enabledBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: Colors.white),
                                      // ),
                                      // focusedBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(color: whiteTextColor),
                                      // ),
                                    )),
                              ),
                              buildSizedBoxHeight(30),
                              Container(
                                height: 45,
                                width: buildWidth(context) / 1.1,
                                child: RaisedButton(
                                    color: buttonCOlor,
                                    onPressed: () {
                                      submitData(context);
                                    },
                                    child: Text("Submit",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ))),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
