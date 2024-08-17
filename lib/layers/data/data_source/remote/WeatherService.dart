import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenWeatherAPI{

  final String OpenWeatherAPIUrl;

  OpenWeatherAPI({required this.OpenWeatherAPIUrl});


  Future getWeatherData() async {
    var OpenWeatherAPIUrlParsed = Uri.parse(OpenWeatherAPIUrl);
    http.Response response = await http.get(OpenWeatherAPIUrlParsed);

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }else{
      print("Some Error Occurred!!!");
      var data = jsonDecode(response.body);
      return data['message'];
    }
  }
}