import 'package:rest_api_flutter/Models/user.dart';
import 'package:rest_api_flutter/Models/user_name.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class UserApi{
  static Future<List<User>> fetchUsers() async {
    print("Fetchusers called");
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e)  {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
         last: e['name']['last']);
        return User(
          cell: e['cell'],
          email: e['email'],
          gender: e['gender'],
          nat: e['nat'],
          phone: e['phone'],
          name: name
        );
      }).toList();
     return users;
  }

}