import 'dart:async';
import 'dart:html';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final authRepository = AuthRepository();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: RootPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('로그인'),
          onPressed: (){
            authRepository.setAuthStatus(AuthState.Authenticated);
          },
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('로그 아웃'),
          onPressed: (){
            authRepository.setAuthStatus(AuthState.Authenticated);
          },
        ),
      ),
    );
  }
}

enum AuthState {
  Authenticated, UnAuthenticated,
}

class AuthRepository {
  AuthState auth = AuthState.UnAuthenticated;

  final StreamController _streamController = StreamController<AuthState>()
    ..add(AuthState.UnAuthenticated);

  get authStream => _streamController.stream;

  setAuthStatus(AuthState state) {
    _streamController.add(state);
  }
}

class RootPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authRepository.authStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == AuthState.UnAuthenticated){
          return LoginPage();
        }
        return MainPage();
      },
    );
  }
}

