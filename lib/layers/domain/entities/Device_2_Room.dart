import 'package:gfi/layers/domain/entities/Device.dart';
import 'package:gfi/layers/domain/entities/Room.dart';

class Device_2_Room {
  Device _device;

  Device get device => _device;

  set device(Device value) {
    _device = value;
  }

  Room _room;

  Room get room => _room;

  set room(Room value) {
    _room = value;
  }

  Device_2_Room({
    required Device device,
    required Room room,
  }) : _room = room, _device = device;
}