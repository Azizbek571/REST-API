
import 'package:flutter/material.dart';
import 'package:rest_api_flutter/Models/user.dart';

import '../services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

   @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rest API call")),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            // final color = user.gender == 'male'? Colors.blue: Colors.red;
            return ListTile(
             
              title: Text(user.fullName),
              subtitle: Text(user.location.postcode),
              // tileColor: color,
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
    );
  }

  Future <void> fetchUsers()async{
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }

}