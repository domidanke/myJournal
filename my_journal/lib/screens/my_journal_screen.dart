import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_journal/constants.dart';

import '../widgets/home_card.dart';
import 'create_entry.dart';

class MyJournalScreen extends StatefulWidget {
  static String id = 'my_journal_screen';

  @override
  _MyJournalScreenState createState() => _MyJournalScreenState();
}

class _MyJournalScreenState extends State<MyJournalScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String userEmail = '';
  String today = getDateFormatted(DateTime.now());
  String lastJournalDate = '2020-05-31';
  int totalJournalEntries = 22;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // ignore: avoid_void_async
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        setState(() {
          userEmail = loggedInUser.email;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    width: 50.0,
                  ),
                  Center(
                    child: Text(
                      'Welcome Back \n $userEmail',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          foreground: Paint()..shader = headerGradient),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            HomeCard(
              image: const AssetImage('images/journal.jpg'),
              text: 'Create Your Journal Entry',
              icon: Icon(
                Icons.create,
                //color: ,
              ),
              headerText: today,
              onTap: () {
                Navigator.pushNamed(context, CreateEntry.id);
              },
            ),
            HomeCard(
              image: const AssetImage('images/journalEdit.jpeg'),
              text: 'Edit Your Last Journal Entry',
              icon: Icon(
                Icons.more_horiz,
                //color: ,
              ),
              headerText: 'Last Entry: $lastJournalDate',
              onTap: () {
                print('Edit Tapped');
              },
            ),
            HomeCard(
              image: const AssetImage('images/calendar.jpeg'),
              text: 'View Your Journal Entry',
              icon: Icon(
                Icons.remove_red_eye,
                //color: ,
              ),
              headerText: 'Total Entries: $totalJournalEntries',
              onTap: () {
                print('View Tapped');
              },
            ),
          ],
        ),
      ),
    );
  }
}
