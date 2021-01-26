import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

final String contactTable = "contactTable";
final String idColumn = "idColumn"; // valor da string não poderá ser alterado
final String nomeColumn = "nomeColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

class ContactHelper{
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();

  Database _db;

Future<Database> get _db async {
    if(_db !=null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }
  Future<Database> initDb() async{
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, "contacts.db");
  // abrindo o banco de dados
  return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async{
    await db.execute(
        "CREATE TABLE  $contactTable($idColumn INTEGER PRIMARY KEY,$nomeColumn TEXT, $emailColumn TEXT, "
            "$phoneColumn TEXT, $imgColumn TEXT)"
    );
  });

  }

  join(String databasesPath, String s) {}
}

class Contact {
  int id;
  String nome;
  String email;
  String phone;
  String img; // local onde a imagem foi armazenada

  Contact.fromMap(Map map){ // armazenameto e formato de mapa
// buscando dados do mapa e passando para o contato
    id = map[idColumn];
    nome = map[nomeColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }
  // ---------função apra transformar contato em mapa------------------------------

  Map toMap(){
    // String armazena o campo, dynamic armazeza a oocorrencia
    Map<String, dynamic> map = {
      nomeColumn: nome,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
      // não colocamos o ID porque quem vai dar o ID será o banco de dados
    } ;
    if(idColumn != null){
      map[idColumn] = id;
    }
    return map;
  }
  @override
  String toString() {
    return "Contact(Id: $id, Nome: $nome, email: $email, Fone: $phone, Imagem: $img)";
  }

}