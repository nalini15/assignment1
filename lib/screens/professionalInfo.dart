import 'dart:io';

import 'package:assignment1/functions/widgetFunction.dart';
import 'package:assignment1/navigations/navigationAnimation.dart';
import 'package:assignment1/screens/addressInfo.dart';
import 'package:assignment1/style/colors.dart';
import 'package:assignment1/viewmodel/profViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'basicInfo.dart';

class ProfessionalInfo extends StatefulWidget {
  @override
  _ProfessionalInfoState createState() => _ProfessionalInfoState();
}

class _ProfessionalInfoState extends State<ProfessionalInfo> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void submitData(BuildContext context) {
    final prof = Provider.of<ProfViewModel>(context, listen: false);
    if (_formKey.currentState.validate()) {
      if (!prof.validateDropDown()) {
        _formKey.currentState.save();
        prof.addData();
        Navigator.push(context, FadeNavigation(widget: AddressInfo()));
      } else {
        showSnack(context, "Please fill the required fields", _scaffoldkey);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: textColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Your Info',
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
          //alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildSizedBoxHeight(30),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Consumer<ProfViewModel>(builder: (context, prof, _) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Educational Info',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            buildSizedBoxHeight(20),
                            Text(
                              'Education*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: textColor)),
                                child: DropdownButton<String>(
                                  items: <String>[
                                    'Post Graduate',
                                    'Graduate',
                                    'HSC/Diploma',
                                    'SSC',
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
                                        "${prof?.formData['education'] ?? "Select Education"}",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  onChanged: (value) {
                                    prof.formData['education'] = value;
                                    prof.reloadFormData();
                                  },
                                )),
                            buildSizedBoxHeight(20),
                            Text(
                              'Year of passing*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: DropdownButton<String>(
                                items: <String>[
                                  '2014',
                                  '2015',
                                  '2016',
                                  '2017',
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
                                      "${prof?.formData['passing'] ?? "Select Year Passing"}",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                onChanged: (value) {
                                  prof.formData['passing'] = value;
                                  prof.reloadFormData();
                                },
                              ),
                            ),
                            buildSizedBoxHeight(20),
                            Text(
                              'Grade*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: prof.grade,
                                  autocorrect: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your grade or percentage';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    prof.formData['grade'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText: 'Enter your Grade or Percentage',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 10.0, 15.0),
                                    isDense: true,
                                  )),
                            ),
                            buildSizedBoxHeight(10),
                            Divider(
                              thickness: 2,
                            ),
                            buildSizedBoxHeight(10),
                            Text(
                              'Professional Info',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            buildSizedBoxHeight(20),
                            Text(
                              'Experience*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: prof.exp,
                                  autocorrect: true,
                                  style: TextStyle(fontSize: 15),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your experience';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    prof.formData['exp'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText: 'Enter the years of experience',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 10.0, 15.0),
                                    isDense: true,
                                  )),
                            ),
                            buildSizedBoxHeight(20),
                            Text(
                              'Designation*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: DropdownButton<String>(
                                items: <String>[
                                  'Software Dev',
                                  'Project Manager',
                                  'Tester',
                                  'HR',
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
                                      "${prof?.formData['design'] ?? "Select Designation"}",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                onChanged: (value) {
                                  prof.formData['design'] = value;
                                  prof.reloadFormData();
                                },
                              ),
                            ),
                            buildSizedBoxHeight(20),
                            Text(
                              'Domain*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: DropdownButton<String>(
                                items: <String>[
                                  'Domain 1',
                                  'Domain 2',
                                  'Domain 3',
                                  'Domain 4',
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
                                      "${prof?.formData['domain'] ?? "Select Domain"}",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                onChanged: (value) {
                                  prof.formData['domain'] = value;
                                  prof.reloadFormData();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
                buildSizedBoxHeight(20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        // width: 20,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: buttonCOlor,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Previous',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ],
                                ))),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        // width: 20,
                        child: FlatButton(
                            onPressed: () {
                              submitData(context);
                            },
                            color: buttonCOlor,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Next',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ],
                                ))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
