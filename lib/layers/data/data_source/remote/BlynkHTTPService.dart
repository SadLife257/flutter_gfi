import 'dart:convert';
import 'dart:io';
import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:http/http.dart' as http;

class BlynkHTTPService {
  static const String URL = 'https://sgp1.blynk.cloud/external/api';
  static const String HEADER_TYPE = 'application/json; charset=UTF-8';
  final String token;


  BlynkHTTPService({
    required this.token,
  });

  Future<Map<String, dynamic>> fetchData() async {
    final data = await Future.wait([
      isDeviceOnline(),
      fetchMQ2(),
      fetchRelay(),
      fetchServo(),
      fetchMQ2Threshold(),
      fetchAutoMode(),
    ]);

    Map<String, dynamic> result = {
      'device_status': jsonDecode(data[0].body) as bool,
      'mq2': jsonDecode(data[1].body) as int,
      'relay': jsonDecode(data[2].body) as int,
      'servo': jsonDecode(data[3].body) as int == 1,
      'mq2_threshold': jsonDecode(data[4].body) as int,
      'auto': jsonDecode(data[5].body) as int == 1,
    };

    return result;
  }

  Future<http.Response> isDeviceOnline() {
    return http.get(
      Uri.parse('$URL/isHardwareConnected?token=$token'),
      headers: <String, String> {
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }

  //MQ2
  Future<http.Response> fetchMQ2() {
    return http.get(
      Uri.parse('$URL/get?token=$token&${Hardware.MQ2}'),
      headers: <String, String> {
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }

  Future<http.Response> updateMQ2(int value) {
    return http.get(
      Uri.parse('$URL/update?token=$token&${Hardware.MQ2}=$value'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }

  //Relay
  Future<http.Response> fetchRelay() {
    return http.get(
      Uri.parse('$URL/get?token=$token&${Hardware.RELAY}'),
      headers: <String, String> {
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      }
    );
  }

  Future<http.Response> updateRelay(int value) {
    return http.get(
      Uri.parse('$URL/update?token=$token&${Hardware.RELAY}=$value'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }

  //Servo
  Future<http.Response> fetchServo() {
    return http.get(
      Uri.parse('$URL/get?token=$token&${Hardware.SERVO}'),
      headers: <String, String> {
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }

  Future<http.Response> updateServo(bool value) {
    int new_value = value ? 1 : 0;

    return http.get(
      Uri.parse('$URL/update?token=$token&${Hardware.SERVO}=$new_value'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }

  //MQ2 Threshold
  Future<http.Response> fetchMQ2Threshold() {
    return http.get(
      Uri.parse('$URL/get?token=$token&${Hardware.MQ2_THRESHOLD}'),
      headers: <String, String> {
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      }
    );
  }

  Future<http.Response> updateMQ2Threshold(int value) {
    return http.get(
      Uri.parse('$URL/update?token=$token&${Hardware.MQ2_THRESHOLD}=$value'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }

  //Auto mode
  Future<http.Response> fetchAutoMode() {
    return http.get(
      Uri.parse('$URL/get?token=$token&${Hardware.AUTO_MODE}'),
      headers: <String, String> {
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      }
    );
  }

  Future<http.Response> updateAutoMode(bool value)  {
    int new_value = value ? 1 : 0;

    return http.get(
      Uri.parse('$URL/update?token=$token&${Hardware.AUTO_MODE}=$new_value'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: HEADER_TYPE,
      },
    );
  }
}