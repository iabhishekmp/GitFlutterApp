import 'package:flutter/material.dart';
import 'package:git_users/providers/user_provider.dart';
import 'package:git_users/providers/users_provider.dart';
import 'package:git_users/views/homepage.dart';
import 'package:git_users/views/user_detail.dart';
import 'package:git_users/widgets/check_network.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UsersProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => CheckNetwork()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: HomePage(),
        ),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          UserDetail.routeName: (ctx) => UserDetail(),
        },
      ),
    );
  }
}
