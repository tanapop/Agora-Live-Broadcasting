import 'package:flutter/material.dart';
import 'posts/post.dart';

TextStyle textStyle = new TextStyle(fontFamily: 'Gotham', color: Colors.white);
TextStyle textStyleBold = new TextStyle(
    fontFamily: 'Gotham', fontWeight: FontWeight.bold, color: Colors.white);
TextStyle textStyleLigthGrey =
    new TextStyle(fontFamily: 'Gotham', color: Colors.grey);

List<Post> userPosts = [
  new Post(new AssetImage('assets/images/photo_1.jpeg'), 'joker',
      'assets/images/profile.png', "My first post", false, false),
  new Post(
      new AssetImage('assets/images/post2.jpg'),
      'akarsh',
      'assets/images/profile4.png',
      "This is such a great post though",
      false,
      false),
];

String title = "Instagram";
