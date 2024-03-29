import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_journal/models/entry.dart';
import 'package:my_journal/models/journal.dart';
import 'package:my_journal/services/data-access_service.dart';
import 'package:my_journal/services/navigation_service.dart';
import 'package:my_journal/widgets/buttons/custom_fab.dart';
import 'package:my_journal/widgets/buttons/toggle_button.dart';
import 'package:my_journal/widgets/entry/entry_card.dart';
import 'package:my_journal/widgets/journal/journal_info_sheet.dart';

import '../../services/locator.dart';
import 'create_entry_screen.dart';

final NavigationService _navigationService = locator<NavigationService>();
final DataAccessService _dataAccessService = locator<DataAccessService>();

class EntryOverviewScreen extends StatefulWidget {
  const EntryOverviewScreen(this.journal);
  final Journal journal;
  static String id = 'entry_overview_screen';
  @override
  _EntryOverviewScreenState createState() => _EntryOverviewScreenState();
}

class _EntryOverviewScreenState extends State<EntryOverviewScreen> {
  Stream entryStream;
  bool sortByRecent = true;

  @override
  void initState() {
    super.initState();
    entryStream = getEntryStream();
  }

  Stream getEntryStream() =>
      _dataAccessService.getEntryStream(widget.journal, sortByRecent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: CustomFab(
          childButtons: [
            SpeedDialChild(
                child: const Icon(Icons.info_outline),
                backgroundColor: Colors.teal[500],
                label: 'Info',
                labelStyle: const TextStyle(color: Colors.black),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return JournalInfoSheet(
                          journal: widget.journal,
                        );
                      });
                }),
            SpeedDialChild(
              child: const Icon(
                Icons.add,
              ),
              backgroundColor: Colors.teal[900],
              label: 'Add Entry',
              labelStyle: const TextStyle(color: Colors.black),
              onTap: () {
                _navigationService.navigateTo(CreateEntryScreen.id,
                    args: widget.journal);
              },
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 32.0,
                    ),
                    onPressed: () {
                      _navigationService.goBack();
                    },
                  ),
                  Text(
                    '${widget.journal.title}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 32.0),
                    child: widget.journal.icon,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: entryStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  final List<EntryCard> entryCards = [];
                  final entryDocs = snapshot.data.docs;
                  for (final QueryDocumentSnapshot entryData in entryDocs) {
                    final entry = Entry(
                      entryID: entryData.id,
                      eventDate: DateTime.parse(
                          entryData['eventDate'].toDate().toString()),
                      feeling: entryData['feeling'],
                      specialDay: entryData['specialDay'],
                      header: entryData['header'],
                      content: entryData['content'],
                      journal: widget.journal,
                    );
                    entryCards.add(EntryCard(entry: entry));
                  }

                  return Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(Icons.arrow_downward),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24.0),
                                    child: ToggleButton(
                                      firstText: 'Recent',
                                      secondText: 'Oldest',
                                      toggle: sortByRecent,
                                      color: Colors.teal[500],
                                      onPressed: () {
                                        setState(() {
                                          sortByRecent = !sortByRecent;
                                        });
                                        entryStream = getEntryStream();
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Expanded(
                              child: ListView(
                                  padding: const EdgeInsets.all(8),
                                  children: entryCards))
                        ]),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              },
            ),
          ],
        )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
