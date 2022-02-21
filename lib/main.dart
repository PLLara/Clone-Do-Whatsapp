import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whatsapp2/common/state/user_state.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/1_initial_screen/1_initial_screen_page.dart';
import 'package:whatsapp2/common/state/contacts_state.dart';
import 'common/themes/default.dart';
import 'features/2_app/2.2_tab_controller.dart/2.0_tab_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    
  });

  try {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    var token = await messaging.getToken(
      vapidKey: "BEHEYXnKisbv8Mlg9tffp2lE9L0wJG_dsN5-IaDLS8wIk1lC95_nruoC7yeCPmO5GTMAx6IRAyKj64ob2gLO5AY",
    );
    print("My FCM token is: $token");
  } catch (e) {}

  return runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.keepFactory,
      title: 'Whatsapp 2',
      theme: defaultDarkTheme(),
      home: LoggedOrNorController(
        key: const Key('loggedOrNot'),
      ),
    );
  }
}

class LoggedOrNorController extends StatefulWidget {
  final ContactsController contactsController = Get.put(
    ContactsController(),
    permanent: true,
  );

  final UserController userController = Get.put(
    UserController(),
    permanent: true,
  );

  LoggedOrNorController({
    Key? key,
  }) : super(key: key) {
    // ignore: avoid_print
    print("--------------------TENTANDO INICIAR O STATE-----------------------");
    contactsController.getContactsFromDevice();
    FirebaseAuth.instance.userChanges().listen(
      (User? newUser) {
        userController.changeUser(newUser);
      },
    );
  }

  @override
  State<LoggedOrNorController> createState() => _LoggedOrNorControllerState();
}

class _LoggedOrNorControllerState extends State<LoggedOrNorController> {
  bool _logged = false;

  _LoggedOrNorControllerState() {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          setState(
            () {
              _logged = false;
            },
          );
        } else {
          setState(
            () {
              _logged = true;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_logged) {
      return const Home();
    }
    return const InicialScreen();
  }
}
