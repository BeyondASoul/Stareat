//PACKAGES
import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:flutter/material.dart';

//USER
import 'package:Stareat/Auth/sign_in.dart';
import 'package:Stareat/FrontEnd/home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Stareat", style: TextStyle(fontSize: 30)),
              SizedBox(height: 50),
              Image(image: AssetImage('assets/images/food.png')),
              SizedBox(height: 50),
              GoogleAuthButton(
                onPressed: () {
                  signInWithGoogle().then(
                    (result) {
                      if (result != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
