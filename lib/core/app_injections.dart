import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../firebase_options.dart';

final di = GetIt.instance;

Future<void> appInjections() async {
  /// Firebase
  final firebase = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.registerSingleton<FirebaseApp>(firebase);

  /// Logs
  final talker = TalkerFlutter.init();
  di.registerSingleton(talker);

  /// Auth
  const scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final googleSignIn = GoogleSignIn(scopes: scopes);
  di.registerSingleton(googleSignIn);
}
