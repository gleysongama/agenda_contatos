import 'package:agendacontatoss/helpers/contact_helper.dart';

class Contact {
  int _id;
  String _name;
  String _email;
  String _phone;
  String _img;

  Contact();

  get id => _id;
  set id(id) {
    _id = id;
  }

  get name => _name;
  set name(name) {
    _name = name;
  }

  get email => _email;
  set email(email) {
    _email = email;
  }

  get phone => _phone;
  set phone(phone) {
    _phone = phone;
  }

  get img => _img;
  set img(img) {
    _img = img;
  }

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn : name,
      emailColumn : email,
      phoneColumn : phone,
      imgColumn : img
    };

    if(id != null) {
      map[idColumn] = id;
    }

    return map;
  }


  @override
  String toString() {
    return "Contact:(id: $id, name: $name, e-mail: $email, phone: $phone, img: $img)";
  }
}