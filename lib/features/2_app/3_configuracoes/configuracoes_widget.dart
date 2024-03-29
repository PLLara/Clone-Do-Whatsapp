import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/common/themes/default.dart';
import 'package:whatsapp2/features/2_app/3_configuracoes/widgets/1_user_identity/user_identity.dart';
import 'package:whatsapp2/features/2_app/3_configuracoes/widgets/common/configuration_option.dart';

class Configuracoes extends StatelessWidget {
  const Configuracoes({
    super.key,
  });

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
              const UserIdentity(),
              const Divider(
                height: 0,
                color: Colors.black,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ConfigurationOption(
                    title: "Conta",
                    subtitle: const Text(
                      "Detalhes, e sei lá oq mais",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: Icons.vpn_key,
                    callback: () {
                      goToPage(
                        Scaffold(
                          appBar: AppBar(),
                          body: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.changeTheme(defaultLightTheme());
                                },
                                child: const Text("Light Theme"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.changeTheme(defaultDarkTheme());
                                },
                                child: const Text("Dark Theme"),
                              ),
                            ],
                          ),
                        ),
                        Get.to,
                      );
                    },
                  ),
                  ConfigurationOption(
                    title: "Conversas",
                    subtitle: const Text("Tema, papel de parede, histórico"),
                    icon: Icons.sms,
                    callback: () {},
                  ),
                  ConfigurationOption(
                    title: "Ajuda",
                    subtitle: const Text("Central de ajuda política de privacidade"),
                    icon: Icons.help_outline,
                    callback: () {},
                  ),
                ],
              ),
            ],
          ),
          const Center(
            child: Column(
              children: [
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
