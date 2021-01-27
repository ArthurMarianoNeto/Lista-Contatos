import 'dart:io';

import 'package:contatos/helpers/contact_helpers.dart';
import 'package:contatos/ui/contact_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  // testando o banco de dados
/*
  @override
  void initState() {
    super.initState();

  Contact c = Contact();
  c.nome = "Zelia Duncan";
  c.email = "zeliaduncan@gmail.com";
  c.phone = "62 886448702";
  c.img = "imgtest";
  
  helper.saveContact(c);

  helper.getAllContacts().then((list){
  print(list);
  });

  }
*/
  List<Contact> contacts = List();


  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showContactPage();
        },
        child:  Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
          itemBuilder: (context, index) {
          return _contactCard(context, index);
        }
      ),
    );
  }
  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget> [
              Container(
               width: 80.0, height: 80.0,
               decoration: BoxDecoration(
                shape: BoxShape.circle,
                 image: DecorationImage(
                   image: contacts[index].img != null ?
                   FileImage(File(contacts[index].img)) :
                       AssetImage("images/person.jpg")
                 ),
               ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(contacts[index].nome ?? "",
                    style: TextStyle(fontSize: 22.0,
                   fontWeight: FontWeight.bold),
                  ),
                  Text(contacts[index].email ?? "",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(contacts[index].phone ?? "",
                    style: TextStyle(fontSize: 18.0),
                  )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: (){
        _showContactPage(contact: contacts[index]);
      },
    );
  }
  void _showContactPage({Contact contact}) async{
   final recContact = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContactPage(contact: contact,))
    );
      if(recContact != null){
        if(Contact != null){
          await helper.updateContact(recContact);
          _getAllContacts();
        } else {
          await helper.saveContact(recContact);
        }
        _getAllContacts();
      }
  }
  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
    });
  }
}
