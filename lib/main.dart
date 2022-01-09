// ignore_for_file: avoid_print, non_constant_identifier_names
import 'package:firebase_core/firebase_core.dart';
import 'package:sheive/features/conversas/presentation/pages/main.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheive/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // By default, this will loop through all contacts using a page size of 20.

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(const MyApp());
}

class TabData {
  final Tab myTab;
  final Widget myWidget;
  TabData({
    required this.myTab,
    required this.myWidget,
  });
}

List<TabData> myTabs = [
  TabData(
    myTab: const Tab(
      text: 'Conversas',
    ),
    myWidget: const Conversas(),
  ),
  TabData(
    myTab: const Tab(
      text: '📷︎',
    ),
    myWidget: const Placeholder(),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        highlightColor: Colors.amber,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
        ),
      ),
      home: DefaultTabController(
        child: const Home(),
        length: myTabs.length,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Controller getState = Get.put(Controller());
    getState;

    return Scaffold(
      appBar: MyAppBar(),
      body: TabBarView(
        physics: const ClampingScrollPhysics(),
        children: [
          for (var tab in myTabs) tab.myWidget
        ],
      ),
    );
  }

  AppBar MyAppBar() {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
      title: const Text("Whatsapp 2"),
      bottom: TabBar(
        indicatorColor: Colors.amber,
        labelColor: Colors.amber,
        unselectedLabelColor: Colors.white,
        physics: const ClampingScrollPhysics(),
        tabs: [
          for (var tab in myTabs) tab.myTab
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            child: const Text("Go to Other"),
            onPressed: () {
              Get.to(
                () => Other(),
                transition: Transition.topLevel,
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Get.snackbar('Hi', 'There', colorText: Colors.amber);
            },
            child: const Text("Snackbar"),
          ),
        ],
      ),
    );
  }
}

class Other extends StatelessWidget {
  Other({Key? key}) : super(key: key);

  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller controller = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text("${controller.pessoa}")),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                controller.increment();
              },
            )
          ],
        ),
      ),
    );
  }
}

class Controller extends GetxController {
  var pessoa = Pessoa(nome: 'asd', idade: 1, doenca: true, cpf: '07164946124').obs;
  increment() {
    pessoa.value.nome = 'pedro';
    pessoa.refresh();
  }
}
