import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'core/app_injections.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appInjections();

  di<Talker>().info('Firebase init: ${di<FirebaseApp>().options.projectId}');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Hello World!'),
            FilledButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TalkerScreen(talker: di<Talker>()),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ],
        ),
      ),
    );
  }
}
