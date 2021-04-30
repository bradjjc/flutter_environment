
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final authRepository = AuthRepository();

void main() {
  runApp(
      MultiProvider(
        child: MyApp(),
        providers: [
          ChangeNotifierProvider.value(
            value: AuthRepository(),
          ),
        ],
      ),
  );
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
            print('login');
            Provider.of<AuthRepository>(context, listen: false)
                .setState(AuthState.Authenticated);
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
            print('logout');
            Provider.of<AuthRepository>(context, listen: false)
                .setState(AuthState.UnAuthenticated);
          },
        ),
      ),
    );
  }
}

enum AuthState {Authenticated, UnAuthenticated,}

class AuthRepository with ChangeNotifier{
  AuthState authState = AuthState.UnAuthenticated;

  setState(AuthState state){
    authState = state;
    notifyListeners();
  }
}

class RootPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthRepository>(context).authState;

    return authState == AuthState.UnAuthenticated ? LoginPage() : MainPage();
  }
}

