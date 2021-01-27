import 'package:contatos/helpers/contact_helpers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();
/*
  Contact c = Contact();
  c.nome = "Arthur Mariano";
  c.email = "thiesto@gmail.com";
  c.phone = "62 996448706";
  c.img = "imgtest";
  
  helper.saveContact(c);
*/
  helper.getAllContacts().then((list){
  print(list);
  });

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
