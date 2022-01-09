import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheive/model.dart';
import 'package:contacts_service/contacts_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(const MyApp());
}

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
      home: const DefaultTabController(
        child: Home(),
        length: 3,
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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Controller getState = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        title: const Text("Whatsapp 2"),
        bottom: const TabBar(
          indicatorColor: Colors.amber,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white,
          physics: ClampingScrollPhysics(),
          tabs: [
            Tab(
              text: "CONVERSAS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CHAMADAS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: const ClampingScrollPhysics(),
        children: [
          Scaffold(
            body: ListView.builder(
              itemBuilder: (_, a) {
                DateTime _now = DateTime.now();
                var title = a.toString() + "ASDASDASDA";
                var icon = Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ],
                );
                return ListTile(
                  onTap: () {
                    Get.to(
                      Scaffold(
                        appBar: AppBar(
                          leading: TextButton(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          title: Row(
                            children: [
                              Column(
                                children: [
                                  Text(title),
                                  const Text("+12312123123"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      transition: Transition.topLevel,
                      duration: Duration(milliseconds: 500),
                    );
                  },
                  leading: icon,
                  title: Text(
                    title,
                  ),
                  subtitle: const Text("Sheive"),
                  trailing: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${_now.hour}:${_now.minute}',
                          style: TextStyle(
                            color: context.theme.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 18,
                            minWidth: 18,
                            maxWidth: 18,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                a.toString(),
                                style: const TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () => Get.to(
                Scaffold(
                  appBar: AppBar(
                    title: const Text("Contatos"),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        ),
                      )
                    ],
                  ),
                  // body: FutureBuilder(
                  //   future: ContactsService.getContacts(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       print(snapshot);
                  //     }
                  //     return Container();
                  //   },
                  // ),
                ),
                transition: Transition.topLevel,
                duration: Duration(milliseconds: 500),
              ),
            ),
          ),
          const Placeholder(),
          const Placeholder(),
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
