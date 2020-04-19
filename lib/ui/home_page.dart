import 'package:agendacontatoss/helpers/contact_helper.dart';
import 'package:agendacontatoss/model/contact.dart';
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
    
    Contact c = Contact();
    c.name = "Ana Paula Gama";
    c.email = "anapaula.gama2018@gmail.com";
    c.phone = "91980893469";
    c.img = "imgtest";

    helper.save(c);

    helper.getAll().then((list){
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
