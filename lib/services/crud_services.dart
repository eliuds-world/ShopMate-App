import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shopmate/services/authentication/auth_exceptions.dart';

class ListsService {
  Database? _db;
  List<DatabaseList> myList = [];

  late final StreamController<List<DatabaseList>> listStreamController;

  //this is  a private initialiser to this class coz we are making a singleton
  static final ListsService _shared = ListsService._sharedInstance();
  ListsService._sharedInstance() {

    //populating lists in our streamcontroler
    listStreamController =
      StreamController<List<DatabaseList>>.broadcast(onListen: () {
      listStreamController.sink.add(myList);
    },);
  }
  factory ListsService() => _shared;

  //this is our getter for getting allnotes
  Stream<List<DatabaseList>> get allLists => listStreamController.stream;

  Future<DatabaseUser> getOrCreateUser({required String email}) async {
    try {
      final user = await getUser(email: email);
      return user;
    } on CouldNotFindUserException {
      final createdUser = await createUser(email: email);
      return createdUser;
    } catch (error) {
      rethrow;
    }
  }

  //this function reads all available notes in my db and cache them in both the streamcontroller and mylist List variable
  Future<void> cacheNotes() async {
    final allLists = await getAllList();
    myList = allLists.toList();
    listStreamController.add(myList);
  }

  Future<DatabaseList> updateList(
      {required DatabaseList list, required String text}) async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    //make sure that the note actually exists
    await getList(id: list.id);

    //update database
    final updatesCount = await db.update(listTable, {
      listTextColumn: text,
    });

    if (updatesCount == 0) {
      throw CouldNotUpdateListException();
    } else {
      final updatedList = await getList(id: list.id);
      myList.removeWhere((list) => list.id == updatedList.id);
      myList.add(updatedList);
      listStreamController.add(myList);
      return updatedList;
    }
  }

  Future<Iterable<DatabaseList>> getAllList() async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final lists = await db.query(
      listTable,
    );

    return lists.map((listRow) => DatabaseList.fromRow(listRow));
  }

  Future<DatabaseList> getList({required int id}) async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final lists = await db.query(
      listTable,
      limit: 1,
      where: "id = ?",
      whereArgs: [id],
    );
    if (lists.isEmpty) {
      throw CouldNotFindListException();
    } else {
      final list = DatabaseList.fromRow(lists.first);
      myList.removeWhere((list) => list.id == id);
      myList.add(list);
      listStreamController.add(myList);
      return list;
    }
  }

  Future<int> deleteAllLists() async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final numberofDeletions = await db.delete(listTable);
    myList = [];
    listStreamController.add(myList);
    return numberofDeletions;
  }

  Future<void> deleteList({required int id}) async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deleteCount = await db.delete(
      listTable,
      where: "id  = ?",
      whereArgs: [id],
    );
    if (deleteCount == 0) {
      throw CouldNotDeleteListException();
    } else {
      myList.removeWhere((list) => list.id == id);
      listStreamController.add(myList);
    }
  }

  Future<DatabaseList> createLists({required DatabaseUser owner}) async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    //confirming that owner exists in the db
    final dbUser = await getUser(email: owner.email);
    if (dbUser != owner) {
      throw CouldNotFindUserException();
    }

    const text = "";
    //create the list
    final listId = await db.insert(listTable, {
      userIdColumn: owner.id,
      listTextColumn: text,
    });
    final list = DatabaseList(
      id: listId,
      userId: owner.id,
      listText: text,
    );

    myList.add(list);
    listStreamController.add(myList);
    return list;
  }

  Future<DatabaseUser> getUser({required String email}) async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: "email = ?",
      whereArgs: [email.toLowerCase()],
    );
    if (results.isEmpty) {
      throw CouldNotFindUserException();
    } else {
      return DatabaseUser.fromRow(results.first);
    }
  }

  Future<DatabaseUser> createUser({required String email}) async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: "email = ?",
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExistsException();
    }

    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });

    return DatabaseUser(
      id: userId,
      email: email,
    );
  }

  Future<void> deleteUser({required String email}) async {
    await ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deleteCount = await db.delete(
      userTable,
      where: "email  = ?",
      whereArgs: [email.toLowerCase()],
    );
    if (deleteCount != 1) {
      throw CouldNotDeleteUserException();
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenedException();
    } else {
      return db;
    }
  }

  Future<void> ensureDbIsOpen() async {
    try {
      await openDb();
    } on DatabaseAlreadyOpenException {}
  }

  Future<void> openDb() async {
    if (_db != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbNmme);
      final db = await openDatabase(dbPath);
      _db = db;

      //creating user Table with sqf code
      await db.execute(createUserTable);

      //create list table with sqf code
      await db.execute(createListTable);

      await cacheNotes();
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    }
  }

  Future<void> closeDb() async {
    final db = _db;
    if (db == null) {
      throw DatabaseIsNotOpenedException();
    } else {
      await db.close();
      _db = null;
    }
  }
}

@immutable
class DatabaseUser {
  final int id;
  final String email;

  const DatabaseUser({
    required this.id,
    required this.email,
  });

  DatabaseUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String;

  @override
  String toString() {
    return "Person,ID =$id,email= $email";
  }

  @override
  bool operator ==(covariant DatabaseUser other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

class DatabaseList {
  final int id;
  final int userId;
  final String listText;

  DatabaseList({
    required this.id,
    required this.userId,
    required this.listText,
  });

  DatabaseList.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        userId = map[userIdColumn] as int,
        listText = map[listTextColumn] as String;

  @override
  String toString() {
    return "lists, ID = $id, userId =$userId, listText = $listText";
  }

  @override
  bool operator ==(covariant DatabaseList other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

const dbNmme = "lists.db";
const listTable = "lists";
const userTable = "user";
const idColumn = "id";
const emailColumn = "email";
const userIdColumn = "user_id";
const listTextColumn = "list_text";
// const isSyncedWithFirebaseColumn = "is_synced_with_firebase";
const createUserTable = '''CREATE TABLE IF NOT EXISTS user (
  Id INTEGER NOT NULL,
  email TEXT NOT NULL UNIQUE,
  PRIMARY KEY(Id AUTOINCREMENT)
);
''';

const createListTable = '''CREATE TABLE IF NOT EXISTS lists (
  id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  list_text TEXT NOT NULL,
  is_synced_with_firebase INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES user(Id)
);
''';
