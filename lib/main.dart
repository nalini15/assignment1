import 'package:assignment1/screens/basicInfo.dart';
import 'package:assignment1/viewmodel/addressViewModel.dart';
import 'package:assignment1/viewmodel/basicViewModel.dart';
import 'package:assignment1/viewmodel/profViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BasicViewModel()),
        ChangeNotifierProvider.value(value: ProfViewModel()),
        ChangeNotifierProvider.value(value: AddressViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BasicInfo(),
      ),
    );
  }
}
