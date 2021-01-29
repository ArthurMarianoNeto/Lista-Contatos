import 'dart:io';

import 'package:contatos/helpers/contact_helpers.dart';
import 'package:contatos/ui/contact_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
enum OrderOptions {orderaz, oderza}

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
        actions: [
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de A - Z"),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de Z - A"),
                value: OrderOptions.oderza,
              ),
            ],
            onSelected: _orderList,
          )
        ],
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
//        _showContactPage(contact: contacts[index]);
      _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
          onClosing: (){

          },
              builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      Padding(
                          padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text("Ligar",
                            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                          ),
                          onPressed: (){
                           launch("tel: ${contacts[index].phone}");
                           Navigator.pop(context);
                          },
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Editar",
                          style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                          _showContactPage(contact: contacts[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Deletar",
                          style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                        ),
                        onPressed: (){
                          helper.deleteContact(contacts[index].id);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
           },
        );
      }
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

  void _orderList(OrderOptions result){
    switch(result){

      case OrderOptions.orderaz:
      contacts.sort((a, b){
        a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
      });
        break;

      case OrderOptions.oderza:
        contacts.sort((a, b){
          b.nome.toLowerCase().compareTo(a.nome.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }

}
