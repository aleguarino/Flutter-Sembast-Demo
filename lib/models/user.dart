import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final int age;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.age,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        age: json['age'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'email': this.email,
        'age': this.age,
      };

  static User fake() => User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: Faker().person.name(),
        email: Faker().internet.email(),
        age: RandomGenerator().integer(50, min: 18),
      );
}
