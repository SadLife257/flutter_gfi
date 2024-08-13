import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/domain/entities/Room.dart';
import 'package:intl/intl.dart';

class RoomCreate extends StatefulWidget {
  const RoomCreate({super.key});

  static const route_name = '/add_room';

  @override
  State<RoomCreate> createState() => _RoomCreateState();
}

class _RoomCreateState extends State<RoomCreate> {

  late final Room newRoom;
  late final TextEditingController roomNameController;
  final roomCreateKey = GlobalKey<FormState>();
  bool _isEmptyInput = true;

  String getTimestamp() {
    DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:sss'Z'");
    return formatter.format(DateTime.now());
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  Future<void> createRoom() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    newRoom = Room(
      name: roomNameController.text.trim(),
      timestamp: DateTime.now(),
      hardware: {}
    );

    DocumentReference docRef = FirebaseFirestore.instance.collection('users_room').doc(userId);
    docRef.get().then((doc) {
      if(doc.exists) {
        FirebaseFirestore.instance.collection('users_room').doc(userId).update({
          newRoom.name: newRoom.toJson()
        });
      }
      else {
        FirebaseFirestore.instance.collection('users_room').doc(userId).set({
          newRoom.name: newRoom.toJson()
        });
      }
    });



    // await FirebaseFirestore.instance.collection('users_info').doc(userId).collection('room').add(newRoom.toJson());
  }

  @override
  void initState() {
    roomNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
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
        body: Center(
          child: Form(
            key: roomCreateKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                        Icons.add_home_outlined,
                        size: 60,
                        color: Theme.of(context).colorScheme.primary
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    AppLocalizations.of(context)!.add_room,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: TextFormField(
                    controller: roomNameController,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.room_name_hint,
                      labelText: AppLocalizations.of(context)!.room_name,
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                      border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      suffix: !_isEmptyInput ? IconButton(
                          alignment: Alignment.topRight,
                          onPressed: () {
                            roomNameController.clear();
                            setState(() {
                              _isEmptyInput = !_isEmptyInput;
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).colorScheme.primary,
                          )
                      ) : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.room_name_error_empty;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 128,
                      vertical: 32
                  ),
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
                        ),
                      ),
                      onPressed: () {
                        if(roomCreateKey.currentState!.validate()) {
                          createRoom().then((_) {
                            Navigator.popUntil(context, ModalRoute.withName('/'));
                          });
                        }
                      },
                      child: Icon(Icons.check),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
