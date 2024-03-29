import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_journal/screens/entry/create_entry_screen.dart';
import 'package:my_journal/screens/entry/entry_overview_screen.dart';
import 'package:my_journal/screens/entry/write_entry_screen.dart';
import 'package:my_journal/screens/journal/create_journal_screen.dart';
import 'package:my_journal/screens/journal/edit_entries_color_screen.dart';
import 'package:my_journal/screens/journal/edit_journal_screen.dart';
import 'package:my_journal/screens/journal/edit_journal_sort_order_screen.dart';
import 'package:my_journal/screens/journal/journal_preview_screen.dart';
import 'package:my_journal/screens/login/auth_screen.dart';
import 'package:my_journal/screens/main/home_screen.dart';
import 'package:my_journal/services/alert_service.dart';
import 'package:my_journal/services/auth_service.dart';
import 'package:my_journal/services/data-access_service.dart';
import 'package:my_journal/services/image_service.dart';
import 'package:my_journal/services/navigation_service.dart';

import 'screens/entry/entry_detail_screen.dart';
import 'screens/login/registration_screen.dart';
import 'screens/login/welcome_screen.dart';
import 'screens/main/main_screen.dart';
import 'services/locator.dart';

Future<void> main() async {
  //region Init App configurations
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DataAccessService());
  locator.registerLazySingleton(() => AlertService());
  locator.registerLazySingleton(() => ImageService());
  //endregion
  runApp(MyJournalApp());
}

class MyJournalApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            navigatorKey: locator<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              /* light theme settings */
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              /* dark theme settings */
            ),
            themeMode: currentMode,
            //region Routes
            routes: {
              AuthScreen.id: (context) => AuthScreen(),
              MainScreen.id: (context) => MainScreen(),
              HomeScreen.id: (context) => const HomeScreen(),
              EditJournalSortOrderScreen.id: (context) =>
                  EditJournalSortOrderScreen(
                      ModalRoute.of(context).settings.arguments),
              WelcomeScreen.id: (context) => WelcomeScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              CreateEntryScreen.id: (context) =>
                  CreateEntryScreen(ModalRoute.of(context).settings.arguments),
              WriteEntryScreen.id: (context) =>
                  WriteEntryScreen(ModalRoute.of(context).settings.arguments),
              CreateJournalScreen.id: (context) => CreateJournalScreen(),
              JournalPreviewScreen.id: (context) => JournalPreviewScreen(
                  ModalRoute.of(context).settings.arguments),
              EntryDetailScreen.id: (context) =>
                  EntryDetailScreen(ModalRoute.of(context).settings.arguments),
              EntryOverviewScreen.id: (context) => EntryOverviewScreen(
                  ModalRoute.of(context).settings.arguments),
              EditEntriesColorScreen.id: (context) => EditEntriesColorScreen(
                  ModalRoute.of(context).settings.arguments),
              EditJournalScreen.id: (context) =>
                  EditJournalScreen(ModalRoute.of(context).settings.arguments),
            },
            initialRoute: AuthScreen.id,
            //endregion
          );
        });
  }
}
