import 'package:gfi/layers/domain/entities/Device/Hardware.dart';
import 'package:gfi/layers/domain/entities/Room.dart';

class Hardware_2_Room {
  Hardware _hardware;

  Hardware get hardware => _hardware;

  set hardware(Hardware value) {
    _hardware = value;
  }

  Room _room;

  Room get room => _room;

  set room(Room value) {
    _room = value;
  }

  Hardware_2_Room({
    required Hardware hardware,
    required Room room,
  }) : _room = room, _hardware = hardware;
}