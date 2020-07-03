import 'package:flutter/material.dart';

final List<IconData> feelingIcons = [
  Icons.clear,
  Icons.cloud,
  Icons.compare_arrows,
  Icons.child_friendly,
  Icons.accessibility_new,
];

class JournalEntry {
  JournalEntry(
      {String headerText,
      String eventDate,
      bool isFavorite,
      int feeling,
      String content}) {
    _headerText = headerText;
    _eventDate = eventDate;
    _isFavorite = isFavorite;
    _feeling = feeling;
    _content = content;
  }

  String _headerText;

  String get headerText => _headerText;
  String _eventDate;
  String _content;
  bool _isFavorite;
  int _feeling;

  Icon getFeelingIcon() {
    return Icon(feelingIcons[_feeling]);
  }

  String get eventDate => _eventDate;

  String get content => _content;

  bool get isFavorite => _isFavorite;

  int get feeling => _feeling;
}