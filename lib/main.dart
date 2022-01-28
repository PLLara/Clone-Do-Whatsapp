// ignore_for_file: avoid_print, non_constant_identifier_names
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp2/features/1_initial_screen/pages/1_initial_screen/1_initial_screen_page.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/1_conversas/contacts_state.dart';
import 'package:whatsapp2/features/2_app/2.1_conversas/2_conversa/state/conversa_state.dart';
import 'features/2_app/2_tab_controller.dart/2.0_tab_controller.dart';
import 'common/themes/default.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // By default, this will loop through all contacts using a page size of 20.

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.keepFactory,
      title: 'Whatsapp 2',
      theme: defaultAppTheme(),
      home: LoggedOrNorController(
        key: const Key('loggedOrNot'),
      ),
    );
  }
}

class LoggedOrNorController extends StatefulWidget {
  final ContactsController contactsController = Get.put(ContactsController(), permanent: true);
  final ConversaController conversaController = Get.put(ConversaController(), permanent: true);
  LoggedOrNorController({
    Key? key,
  }) : super(key: key) {
    print("-----------------------------------------------------------------------------------TENTANDO INICIAR O STATE");
    if (conversaController.iniciado.value != true) {
      conversaController.start();
      contactsController.getContactsFromDevice();
    }
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
