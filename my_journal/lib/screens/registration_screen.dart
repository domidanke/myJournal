import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_journal/screens/my_journal_screen.dart';
import 'package:my_journal/widgets/rounded_button.dart';
import 'package:my_journal/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  void alertUser(String alertTitle, String alertMessage) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        if (Theme.of(context).platform == TargetPlatform.android) {
          return AlertDialog(
            title: Text(alertTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(alertMessage),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(alertTitle),
            content: Text(alertMessage),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                key: Key('email'),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                key: Key('password'),
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  if (password == null || email == null) {
                    alertUser(
                      'Registration failed',
                      'Email and password cannot be blank.',
                    );
                  } else {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (newUser != null) {
                        setState(() {
                          showSpinner = false;
                        });

                        Navigator.pushNamed(context, MyJournalScreen.id);
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      print('Something went wrong: $e');
                      switch (e.code) {
                        case 'ERROR_INVALID_EMAIL':
                          {
                            alertUser(
                              'Registration failed',
                              'Please enter a valid email address.',
                            );
                          }
                          break;
                        case 'ERROR_WEAK_PASSWORD':
                          {
                            alertUser(
                              'Registration failed',
                              'The password must be at least 6 characters long.',
                            );
                          }
                          break;
                        case 'ERROR_EMAIL_ALREADY_IN_USE':
                          {
                            alertUser(
                              'Registration failed',
                              'The email address is already in use by another account.',
                            );
                          }
                          break;
                        default:
                          {
                            alertUser(
                              'Registration failed',
                              'Something went wrong. Please try again later.',
                            );
                          }
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
