import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:palestine_console/palestine_console.dart';
import 'package:whatsapp2/features/2_app/0_web_layout/web_layout.dart';
import 'package:whatsapp2/state/global/contacts_state.dart';
import 'package:whatsapp2/state/global/conversas_state.dart';
import 'common/themes/default.dart';
import 'features/1_initial_screen/1_initial_screen/1_initial_screen_page.dart';
import 'features/2_app/state_and_tab_controller.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  Paint.enableDithering = false;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // ! Versão desktop
    return GetMaterialApp(
      smartManagement: SmartManagement.keepFactory,
      title: 'Clone do Zap',
      theme: defaultDarkTheme(),
      home: LoggedOrNorController(),
    );
  }
}

class LoggedOrNorController extends StatefulWidget {
  LoggedOrNorController({
    super.key,
  }) {
    Print.green("-------------------- TENTANDO INICIAR O STATE -----------------------");
    FirebaseAuth.instance.userChanges().listen(
      (User? user) {
        if (user != null) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          firestore.collection('usuarios').doc(user.phoneNumber).set({
            'id': user.uid,
            'nome': user.displayName,
            'email': user.email,
            'numero': user.phoneNumber,
            'foto': user.photoURL
          });
        } else {
          Print.red('---------- EXITING USER SESSION AND DISPOSING CONTROLLERS ----------');
          Get.offAllNamed('/');
          Get.delete<ConversasPathController>();
          Get.delete<ContactsController>();
        }
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
        setState(() {
          _logged = user != null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_logged) {
      return const TabSwitcherAndProvider();
    }
    return const Whatsapp2WebLayoutBase(
      child: InicialScreen(),
    );
  }
}
