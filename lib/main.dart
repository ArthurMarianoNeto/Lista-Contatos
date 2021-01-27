import 'package:contatos/ui/contact_page.dart';
import 'package:contatos/ui/home_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main (){
  runApp(MaterialApp(
    home: ContactPage( ),
    debugShowCheckedModeBanner: false,
  ));
  
}