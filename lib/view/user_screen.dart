import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:population_app_api/model/user_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<User>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _getUsersFromJson();
  }

  Future<List<User>> _getUsersFromJson() async {
    const url = 'https://jsonplaceholder.typicode.com/users';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<User> users = jsonList.map((json) => User.fromJson(json)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder<List<User>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data loaded successfully
            List<User>? users = snapshot.data;
            if (users != null && users.isNotEmpty) {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index].name.toString()),
                    subtitle: Text(users[index].email.toString()),
                  );
                },
              );
            } else {
              return const Center(child: Text('No users found'));
            }
          }
        },
      ),
    );
  }
}
