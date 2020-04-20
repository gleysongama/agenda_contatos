import 'dart:io';
import 'dart:ui';

import 'package:agendacontatoss/helpers/contact_helper.dart';
import 'package:agendacontatoss/model/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();


  @override
  void initState() {
    super.initState();

    helper.getAll().then((list) {
      if(list.length > 0) {
        setState(() {
          contacts = list;
        });
      } else {
        Contact c = Contact();
        c.name = "Gleyson Gama";
        c.email = "gleysongama@gmail.com";
        c.phone = "91980893469";
        c.img = "imgtest";

        Contact a = Contact();
        a.name = "Ana Paula Pereira Gama";
        a.email = "anapaula.gama2018@gmail.com";
        a.phone = "91980893469";
        a.img = "imgtest";

        helper.save(c);
        helper.save(a);

        helper.getAll().then((list) {
          setState(() {
            contacts = list;
          });
        });
      }
    });
  }

  /*@override
  void initState() {
    super.initState();

    *//*Contact c = Contact();
    c.name = "Gleyson Gama";
    c.email = "gleysongama@gmail.com";
    c.phone = "91980893469";
    c.img = "imgtest";*//*

    helper.save(c);

    helper.getAll().then((list){
      print(list);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: contacts[index].img != null ?
                        FileImage(File(contacts[index].img)) :
                        AssetImage("images/contact.png")
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contacts[index].name ?? "",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        contacts[index].email ?? "",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        contacts[index].phone ?? "",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
