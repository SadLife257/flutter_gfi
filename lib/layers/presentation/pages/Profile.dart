import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/domain/entities/UserDetail.dart';
import 'package:gfi/layers/presentation/pages/AboutUs.dart';
import 'package:gfi/layers/presentation/pages/AuthReDirect.dart';
import 'package:gfi/layers/presentation/widgets/info_box.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  static const route_name = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final UserDetail user;
  bool isUserLoaded = false;
  bool isProfileImageLoaded = false;
  final ImagePicker imagePicker = ImagePicker();
  late Uint8List? profileImage;

  @override
  void initState() {
    getUser().then((_) {
      getProfileImage();
    });
    super.initState();
  }

  Future getUser() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseFirestore.instance.collection('users_info').doc(userId).withConverter(
      fromFirestore: UserDetail.fromJson,
      toFirestore: (UserDetail user, _) => user.toJson(),
    );
    final docSnap = await ref.get();
    user = docSnap.data()!;

    setState(() {
      isUserLoaded = true;
    });
  }

  Future getProfileImage() async {
    FirebaseStorage.instance.ref().child(user.imageUrl).getData(1024 * 1024 * 10).then((data) {
      setState(() {
        profileImage = data;
        isProfileImageLoaded = true;
      });
    });
  }

  Future<void> pickImage() async {
    try {
      XFile? res = await imagePicker.pickImage(source: ImageSource.gallery);

      if(res != null) {
        await uploadImageToFirebase(File(res.path)).then((_) async {
          final userId = FirebaseAuth.instance.currentUser!.uid;
          await FirebaseFirestore.instance.collection('users_info').doc(userId).set(user.toJson()).then((_) {
            getProfileImage();
          });
        });
      }
      else {
        setState(() {
          isProfileImageLoaded = true;
        });
      }
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            AppLocalizations.of(context)!.profile_img_pick_fail,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          )
        )
      );
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final imagePath = "images/$userId/${DateTime.now().microsecondsSinceEpoch}.png";
      Reference ref = FirebaseStorage.instance.ref().child(imagePath);
      await ref.putFile(image).whenComplete(() => {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: Text(
                  AppLocalizations.of(context)!.profile_img_upload_success,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                )
            )
        )
      });
      user.imageUrl = imagePath;
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              content: Text(
                AppLocalizations.of(context)!.profile_img_upload_fail,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              )
          )
      );
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AuthReDirect(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.profile,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 30,
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )
          ),
        ),
        body: !(isUserLoaded && isProfileImageLoaded) ? Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        )
            :
        ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ClipOval(
                  child: Container(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Image.memory(
                      width: 300.0,
                      height: 300.0,
                      profileImage!,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    )
                ),
                onPressed: () {
                  setState(() {
                    isProfileImageLoaded = false;
                  });
                  pickImage();
                },
                label: Text(AppLocalizations.of(context)!.upload),
                icon: Icon(Icons.edit),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                        AppLocalizations.of(context)!.profile_info,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            InfoBox(
              title: AppLocalizations.of(context)!.username,
              detail: '${user.firstname} ${user.lastname}',
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              isChangeable: true,
            ),
            InfoBox(
              title: AppLocalizations.of(context)!.email,
              detail: user.email.toString(),
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
            ),
            InfoBox(
              title: AppLocalizations.of(context)!.password,
              backgroundColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.primary,
              titleColor: Theme.of(context).colorScheme.secondary,
              detailColor: Theme.of(context).colorScheme.primary,
              iconColor: Theme.of(context).colorScheme.primary,
              isChangeable: true,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      AppLocalizations.of(context)!.profile_operation,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: Size.fromHeight(60),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      )
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AboutUs())
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.about_us_cap),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      minimumSize: Size.fromHeight(60),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      )
                  ),
                  onPressed: signOut,
                  child: Text(AppLocalizations.of(context)!.logout_cap),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
