// ignore_for_file: avoid_print, non_constant_identifier_names
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp2/common/state/user_state.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/1_initial_screen/1_initial_screen_page.dart';
import 'package:whatsapp2/common/state/contacts_state.dart';
import 'common/themes/default.dart';
import 'features/2_app/2.2_tab_controller.dart/2.0_tab_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    cameras = await availableCameras();
  } catch (e) {
    cameras = [];
    print("COE A CAMERA NÃO FUNCIONA!");
  }
  return runApp(const MyApp());
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
  final ContactsController contactsController = Get.put(ContactsController(), permanent: true);
  final UserController userController = Get.put(UserController(), permanent: true);

  LoggedOrNorController({
    Key? key,
  }) : super(key: key) {
    print("-------------------------------------------TENTANDO INICIAR O STATE");
    contactsController.getContactsFromDevice();
    FirebaseAuth.instance.userChanges().listen((User? newUser) {
      userController.changeUser(newUser);
    });
  }

  @override
  State<LoggedOrNorController> createState() => _LoggedOrNorControllerState();
}

class _LoggedOrNorControllerState extends State<LoggedOrNorController> {
  _LoggedOrNorControllerState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("AUTH STATE CHANGES");
      print(user);
      if (user == null) {
        setState(() {
          _logged = false;
        });
      } else {
        setState(() {
          _logged = true;
        });
      }
      print("Logged-> " + _logged.toString());
    });
  }
  bool _logged = false;

  @override
  Widget build(BuildContext context) {
    if (_logged) {
      return Home(cameras);
    }
    return const InicialScreen();
  }
}
