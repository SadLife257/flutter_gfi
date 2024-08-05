import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/domain/entities/Room.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DeviceScan extends StatefulWidget {
  const DeviceScan({super.key});

  static const route_name = '/scan_device';

  @override
  State<DeviceScan> createState() => _DeviceScanState();
}

class _DeviceScanState extends State<DeviceScan> {
  bool isDetected = false;
  late Hardware hardware;
  late Room room;

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  Future<void> addDevice() async {
    setState(() {
      isDetected = true;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;

    String key;
    do {
      key = generateRandomString(32);
      room.hardware[key] = hardware;
      room.timestamp = DateTime.now();

      await FirebaseFirestore.instance.collection('users_room').doc(userId).update({
        room.name: room.toJson(),
      });
    } while(! room.hardware.containsKey(key));
  }

  void showWrongCode() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(
              'Wrong QR code',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            content: Text(
              'It seem like you scan the wrong QR to connect to our device',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)!.settings.arguments as Room;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            'Scan Device',
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
        body: isDetected ? Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        )
        :
        MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            returnImage: true,
          ),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              final value = barcode.rawValue!.split('\n');
              if(value.length == 2) {
                hardware = Hardware(
                  name: value[0],
                  image_url: 'assets/images/gas-bottle.png',
                  token: value[1],
                );
                addDevice().then((_) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                });
                break;
              }
              else {
                showWrongCode();
              }
            }
          },
        ),
      )
    );
  }
}
