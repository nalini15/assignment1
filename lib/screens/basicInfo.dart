import 'dart:io';

import 'package:assignment1/functions/widgetFunction.dart';
import 'package:assignment1/navigations/navigationAnimation.dart';
import 'package:assignment1/screens/professionalInfo.dart';
import 'package:assignment1/style/colors.dart';
import 'package:assignment1/viewmodel/basicViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    "fname": "",
    "lname": "",
    "contact": "",
    "email": "",
    "password": "",
    "isMale": false,
    "conPass": "",
  };

  bool _showPassword = false;
  int _groupValue = -1;

  void submitForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final basicInfo = Provider.of<BasicViewModel>(context, listen: false);
      if (formData['conPass'] != formData['password']) {
        showSnack(context, "Password and confirm password should match",
            _scaffoldkey);
      } else {
        formData.remove("conPass");
        basicInfo.loadData(formData);
        Navigator.push(context, FadeNavigation(widget: ProfessionalInfo()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Register',
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
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 51,
                          backgroundColor: textColor,
                          child: ClipOval(
                            child: _image == null
                                ? Image.asset(
                                    'assets/images/user.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(_image),
                          ),
                        ),
                        Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.create_rounded,
                                color: Colors.black,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: textColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  )),
                            ))
                      ],
                    ),
                  ),
                  //  buildSizedBoxHeight(5),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child:
                        Consumer<BasicViewModel>(builder: (context, basic, _) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: basic.fname,
                                  autocorrect: true,
                                  style: TextStyle(fontSize: 15),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  validator: (value) {
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    formData['fname'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: buttonCOlor,
                                    ),
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText: 'Enter your first name',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 10.0, 15.0),
                                    isDense: true,
                                  )),
                            ),
                            buildSizedBoxHeight(20),
                            Text(
                              'Last Name*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: basic.lname,
                                  autocorrect: true,
                                  style: TextStyle(fontSize: 15),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
                                  validator: (value) {
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    formData['lname'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: buttonCOlor,
                                    ),
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText: 'Enter your last name',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
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
                            Text(
                              'Phone Number*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: basic.contact,
                                  autocorrect: true,
                                  style: TextStyle(fontSize: 15),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  validator: (value) {
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your number';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    formData['contact'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.call,
                                      color: buttonCOlor,
                                    ),
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText:
                                        'Enter your 10 digit phone number',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
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
                            Text(
                              'Email*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: basic.email,
                                  autocorrect: true,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value.trimRight().trimLeft());
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!emailValid) {
                                      return 'Invalid email!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    formData['email'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: buttonCOlor,
                                    ),
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText: 'Your email goes here',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
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
                            Text(
                              'Gender*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                    value: true,
                                    groupValue: basic.isMale,
                                    title: Text("Male"),
                                    onChanged: (newValue) {
                                      basic.changeUserGender(newValue);
                                      formData['isMale'] = newValue;
                                    },
                                    activeColor: buttonCOlor,
                                    selected: false,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RadioListTile(
                                    value: false,
                                    groupValue: basic.isMale,
                                    title: Text("Female"),
                                    onChanged: (newValue) {
                                      basic.changeUserGender(newValue);
                                      formData['isMale'] = newValue;
                                    },
                                    activeColor: buttonCOlor,
                                    selected: false,
                                  ),
                                ),
                              ],
                            ),
                            buildSizedBoxHeight(20),
                            Text(
                              'Pasword*',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: basic.password,
                                  obscureText: !basic.showPassword,
                                  // keyboardType: TextInputType.visiblePassword,
                                  autocorrect: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length > 20) {
                                      return 'Password should be max 20 characters!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    formData['password'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: buttonCOlor,
                                    ),
                                    suffixIcon: IconButton(
                                      iconSize: 30,
                                      icon: Icon(
                                        Icons.visibility_off,
                                        color: this._showPassword
                                            ? Colors.grey
                                            : buttonCOlor,
                                      ),
                                      onPressed: () {
                                        basic
                                            .changePassVisi(basic.showPassword);
                                      },
                                    ),
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
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
                            Text(
                              'Confirm Password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            buildSizedBoxHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: textColor)),
                              child: TextFormField(
                                  initialValue: basic.password,
                                  obscureText: true,
                                  autocorrect: true,
                                  style: TextStyle(fontSize: 15),
                                  validator: (value) {
                                    if (value.trimRight().trimLeft().isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length > 20) {
                                      return 'Password should be max 20 characters!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    formData['conPass'] =
                                        value.trimLeft().trimRight();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: buttonCOlor,
                                    ),
                                    errorStyle: TextStyle(
                                        // color: whiteTextColor,
                                        ),
                                    hintText: 'Confirm Password',
                                    hintStyle: TextStyle(color: textColor1),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
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
                              height: 45,
                              width: buildWidth(context) / 1.1,
                              child: RaisedButton(
                                  color: buttonCOlor,
                                  onPressed: () {
                                    submitForm(context);
                                  },
                                  child: Text("Next",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ))),
                            ),
                            buildSizedBoxHeight(10),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
