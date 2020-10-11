import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_journal/constants.dart';
import 'package:my_journal/generated/l10n.dart';
import 'package:my_journal/screens/registration_screen.dart';
import 'package:my_journal/widgets/custom_alert.dart';
import 'package:my_journal/widgets/rounded_button.dart';

import 'journal_entry_overview_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  void alertUser(String alertMessage) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlert(
          alertTitle: 'Login failed',
          alertMessage: alertMessage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  Text(
                    'MyJournal',
                    style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        foreground: Paint()..shader = headerGradient),
                  ),
                ],
              ),
              const SizedBox(
                height: 36.0,
              ),
              TextField(
                key: const Key('email'),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: S.of(context).loginScreenEmailTextFieldHint,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (String value) {
                  //Do something with the user input.
                  email = value;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  key: const Key('password'),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldInputDecoration.copyWith(
                    hintText: S.of(context).loginScreenPasswordTextFieldHint,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (String value) {
                    password = value;
                  }),
              const SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                text: S.of(context).loginScreenLoginButton,
                color: const Color(0xff5f2c82),
                onPressed: () async {
                  if (password == null || email == null) {
                    alertUser(S.of(context).errorBlankField);
                  } else {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      final AuthResult authResult =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (authResult != null) {
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JournalEntryOverviewScreen()));
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                      switch (e.code) {
                        case 'ERROR_INVALID_EMAIL':
                          {
                            alertUser(
                                S.of(context).loginScreenErrorInvalidEmail);
                          }
                          break;
                        case 'ERROR_USER_NOT_FOUND':
                          {
                            alertUser(
                                S.of(context).loginScreenErrorUserNotFound);
                          }
                          break;
                        case 'ERROR_WRONG_PASSWORD':
                          {
                            alertUser(
                                S.of(context).loginScreenErrorWrongPassword);
                          }
                          break;
                        default:
                          {
                            alertUser(S.of(context).loginScreenErrorDefault);
                          }
                      }
                    }
                  }
                },
              ),
              GestureDetector(
                key: const Key('RegisterButton'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()));
                },
                child: Center(
                    child: Text(
                  S.of(context).loginScreenRegistrationButton,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
