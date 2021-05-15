import 'package:flutter/material.dart';
import 'package:quiz_marker/services/auth.dart';
import 'package:quiz_marker/view/home.dart';
import 'package:quiz_marker/widgets/widgets.dart';
import 'package:quiz_marker/view/signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(
        () {
          _isLoading = true;
        },
      );
      await authService.signUpWithEmailAndPassword(email, password).then(
        (value) {
          if (value != null) {
            setState(
              () {
                _isLoading = false;
              },
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child:
                          // Spacer(),
                          TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "Enter a name" : null;
                        },
                        decoration: InputDecoration(hintText: "Name"),
                        onChanged: (val) {
                          name = val;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        height: 6,
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "Enter correct email" : null;
                        },
                        decoration: InputDecoration(hintText: "Email"),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      flex: 0,
                      child: TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.isEmpty ? "Enter a password" : null;
                        },
                        decoration: InputDecoration(hintText: "Password"),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        height: 24,
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: GestureDetector(
                        onTap: () {
                          signUp();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 18,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 15.5,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
