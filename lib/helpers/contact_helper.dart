import 'package:agendacontatoss/model/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String contactTable = "contactTable";
final String idColumn = "idColum";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $contactTable("
            "$idColumn INTEGER PRIMARY KEY,"
            "$nameColumn TEXT,"
            "$emailColumn TEXT,"
            "$phoneColumn TEXT,"
            "$imgColumn TEXT)"
      );
    });
  }

  Future<Contact> save(Contact contact) async {
    Database db = await this.db;
    contact.id = await db.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getById(int id) async {
    Database db = await this.db;
    List<Map> maps = await db.query(
      contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );
    if(maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    return db.delete(
      contactTable,
      where: "$idColumn = ?",
      whereArgs: [id]
    );
  }

  Future<int> update(Contact contact) async {
    Database db = await this.db;
    return await db.update(
      contactTable,
      contact.toMap(),
      where: "$idColumn = ?",
      whereArgs: [contact.id]
    );
  }

  Future<List> getAll() async {
    Database db = await this.db;
    List listMap = await db.rawQuery(
      "SELECT * FROM $contactTable"
    );
    List<Contact> listContact = List();
    for(Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int>getNumber() async {
    Database db = await this.db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database db = await this.db;
    db.close();
  }

}