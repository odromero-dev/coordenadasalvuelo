import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto4/control/control.dart';
import 'package:reto4/interfaz/home.dart';

void main() {
  Get.put(control());
  runApp(const MyApp());
}
