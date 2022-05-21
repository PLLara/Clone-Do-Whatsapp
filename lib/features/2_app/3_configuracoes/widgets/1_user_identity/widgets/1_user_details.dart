import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/2_app/2_app_content/2.1_conversas/2_conversa/widgets/4_bottom_form/widgets/1_text_image_form/1_text_image_form.dart';
import '../../../../../../common/widgets/user_photo.dart';
import '../../common/configuration_option.dart';
import '../user_identity.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: TextButton(
              onPressed: () async {
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
                  builder: (context) => const ChangePhotoUrl(
                    key: Key('ChangePhotoUrl'),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Hero(
                  tag: 'avatar',
                  child: UserPhotoWidget(
                    size: 70,
                  ),
                ),
              ),
            ),
          ),
          ConfigurationOption(
            title: 'Nome',
            subtitle: FirebaseAuth.instance.currentUser?.displayName ?? '',
            icon: Icons.person,
            endIcon: Icons.edit,
            callback: () {
              showModalBottomSheet(
                context: context,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                  minHeight: MediaQuery.of(context).size.height * 0.5,
                ),
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

class ChangePhotoUrl extends StatelessWidget {
  const ChangePhotoUrl({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Text(
                "Foto do perfil",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                iconSize: 50,
                icon: Column(
                  children: const [
                    Icon(Icons.photo_camera),
                    Text("Camera"),
                  ],
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 50,
                icon: Column(
                  children: const [
                    Icon(Icons.image),
                    Text("Galeria"),
                  ],
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  var user = FirebaseAuth.instance.currentUser;
                  XFile? image = await getImageFromGallery();
                  Get.showSnackbar(
                    const GetSnackBar(
                      duration: Duration(milliseconds: 2000),
                      title: "Carregando",
                      message: " ",
                    ),
                  );
                  if (image == null || user == null) {
                    return;
                  }
                  var ref = FirebaseStorage.instance.ref('perfil/${user.uid}');
                  var result = await sendImageToFirebase(ref, image);
                  var imageUrl = await result.ref.getDownloadURL();
                  await user.updatePhotoURL(imageUrl);
                  Get.showSnackbar(
                    const GetSnackBar(
                      duration: Duration(milliseconds: 2000),
                      title: "Deu certo :)",
                      message: " ",
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
