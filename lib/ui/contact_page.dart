import 'dart:io';
import 'package:contatos/helpers/contact_helpers.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _userEdited = false;
  Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(_editedContact.nome ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0) ,
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 140.0, height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _editedContact.img != null ?
                      FileImage(File(_editedContact.img)) :
                      AssetImage("images/person.jpg")
                  ),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Nome"
              ),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedContact.nome = text;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
