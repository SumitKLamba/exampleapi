import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_example/datetimemodel.dart';
import 'user_model.dart';

class WorldTime{
  String location;
  String time;
  String url;
  WorldTime({this.time, this.location, this.url});

  
  Future<void> getTime() async{
    final response = await http.get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    DateTimeModel dateTimeModel = DateTimeModel.fromJson(data);
    print(dateTimeModel.utcOffset);

    String datetime = data['datetime'];
    print(datetime);

    DateTime now = DateTime.parse(datetime);

    time= now.toString();
  }

  Future<UserModel> createUser(String name, String jobTitle) async{
  final String apiUrl = "https://reqres.in/api/users";

  final response = await http.post(apiUrl, body: {
    "name": name,
    "job": jobTitle
  });

  if(response.statusCode == 201){
    final String responseString = response.body;
    
    return userModelFromJson(responseString);
  }else{
    return null;
  }
}

}