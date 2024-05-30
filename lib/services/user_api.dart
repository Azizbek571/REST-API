import 'dart:html';

import 'package:rest_api_flutter/Models/user.dart';
import 'package:rest_api_flutter/Models/user_dob.dart';
import 'package:rest_api_flutter/Models/user_location.dart';
import 'package:rest_api_flutter/Models/user_name.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static Future<List<User>> fetchUsers() async {
    print("Fetchusers called");
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      final name = UserName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);
          final date =  e['dob']['date'];
      final dob = UserDob(
        age: e['dob']['age'], 
      date: DateTime.parse(date)
      );
  final coordinates= LocationCoordinate(latitude:e['location'] ['coordinates'] ['latitude'],
   longtude:e['location'] ['coordinates'] ['longtude']);

  final street = LocationStreet(name:e['location'] ['street'] ['name'],
   number: e['location'] ['street'] ['number'],);
    

    final timezone = LocationTimezone(
      description: e['location'] ['timezone'] ['description'],
       offset:e['location'] ['timezone'] ['offset']);

    final location = UserLocation(
      city:e['location'] ['city'], 
    country: e['location'] ['country'],
     postcode:e['location'] ['postcode'].toString(),
    state:e['location'] ['state'], 

      street: street, 
      coordinates: coordinates,
       timezone: timezone);
      return User(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        nat: e['nat'],
        phone: e['phone'],
        name: name,
        dob: dob,
        location: location
      );
    }).toList();
    return users;
  }
}
