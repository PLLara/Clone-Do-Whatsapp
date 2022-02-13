// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/common/state/user_state.dart';
import 'package:whatsapp2/common/themes/default.dart';

class Configuracoes extends StatelessWidget {
  const Configuracoes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserIdentity(
                onTap: () {
                  goToPage(
                    UserDetails(
                      key: const Key('userdetails'),
                    ),
                  );
                },
              ),
              const Divider(
                height: 0,
                color: Colors.black,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ConfigurationOption(
                    title: "Conta",
                    subtitle: "Detalhes, e sei lá oq mais",
                    icon: Icons.vpn_key,
                    callback: () {
                      Get.to(
                        () => Scaffold(
                          appBar: AppBar(),
                          body: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.changeTheme(defaultLightTheme());
                                },
                                child: const Text("DiaNoite"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.changeTheme(defaultDarkTheme());
                                },
                                child: const Text("DiaNoite"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const ConfigurationOption(
                    title: "Conversas",
                    subtitle: "Tema, papel de parede, histórico",
                    icon: Icons.sms,
                  ),
                  const ConfigurationOption(
                    title: "Ajuda",
                    subtitle: "Central de ajuda política de privacidade",
                    icon: Icons.help_outline,
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Column(
              children: const [
                Text(
                  'de',
                  style: TextStyle(color: Colors.white70),
                ),
                Text('Pedro Lara'),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  UserDetails({
    Key? key,
  }) : super(key: key);

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: 'avatar',
              child: TextButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    radius: 70,
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () {
              return ConfigurationOption(
                title: 'Nome',
                subtitle: userController.user.value?.displayName ?? '',
                icon: Icons.person,
                endIcon: Icons.edit,
                callback: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          5.0,
                        ),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (context) => const ChangeNameBottomSheet(),
                  );
                },
              );
            },
          ),
          const Divider(
            height: 0,
            color: Colors.black,
          ),
          ConfigurationOption(
            title: 'Telefone',
            subtitle: FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
            icon: Icons.phone,
          ),
        ],
      ),
    );
  }
}

class ChangeNameBottomSheet extends StatefulWidget {
  const ChangeNameBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeNameBottomSheet> createState() => _ChangeNameBottomSheetState();
}

class _ChangeNameBottomSheetState extends State<ChangeNameBottomSheet> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("CANCELAR"),
              ),
              TextButton(
                onPressed: () async {
                  var newUserName = nameController.text;
                  Get.back();
                  await FirebaseAuth.instance.currentUser?.updateDisplayName(newUserName).then(
                        (value) => {
                          Get.showSnackbar(
                            const GetSnackBar(
                              duration: Duration(milliseconds: 2000),
                              title: "Success",
                              message: ":)",
                            ),
                          )
                        },
                      );
                },
                child: const Text("SALVAR"),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Insira seu nome',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              controller: nameController,
              autofocus: true,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ConfigurationOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  final IconData? endIcon;

  final VoidCallback? callback;

  const ConfigurationOption({Key? key, required this.title, required this.subtitle, required this.icon, this.endIcon, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      leading: SizedBox(
        width: 50,
        child: Center(
          child: Icon(icon),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Colors.white70,
            ),
      ),
      trailing: Icon(endIcon),
    );
  }
}

class UserIdentity extends StatelessWidget {
  VoidCallback onTap;

  UserIdentity({Key? key, required this.onTap}) : super(key: key);

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      User? currentUser = userController.user.value;
      var phoneNumber = (currentUser?.phoneNumber ?? '').toString();
      var name = currentUser?.displayName;
      var asd = currentUser?.metadata;
      return ListTile(
        onTap: onTap,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Hero(
                tag: 'avatar',
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? 'SEM NOME AINDA'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(asd?.creationTime.toString() ?? 'SEM DESCRIÇÃO'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
