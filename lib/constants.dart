import 'package:flutter/material.dart';
const kBumbleYellow = Color(0xffFFC629);
const kWhite=Colors.white;
InputDecoration kTextFieldInputDecoration=const InputDecoration(
  filled: true,
  fillColor: Color(0xffFFFFFF),

  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
  border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10))),
  hintText: 'Phone number',
  hintStyle: TextStyle(color: Colors.grey,fontSize: 18),

);