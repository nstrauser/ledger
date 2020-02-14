import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:async/async.dart';
import 'bill.dart';

class BillsHandler {

  final databaseName = 'bills.db';
  final tableName = 'bills';

  final fieldMap = {
    'id': "INTEGER PRIMARY KEY AUTOINCREMENT",
    'title': 'TEXT',
    'dueDaye': 'TEXT',
    'amount': 'TEXT',
    'billPaid': 'INTEGER',
    'isArchived': 'TEXT',
    'notes': 'TEXT',
  };

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    var path = await getDatabasesPath();
    var dbPath = join(path, 'bills.db');
    Database dbConnection = await openDatabase(
        dbPath, version: 1, onCreate: (Database db, int version) async {
      await db.execute(_buildCreateQuery());
    });

    await dbConnection.execute(_buildCreateQuery());
    _buildCreateQuery();
    return dbConnection;
  }

    String _buildCreateQuery() {
      String query = 'CREATE TABLE IF NOT EXISTS ';
      query += tableName;
      query += '(';
      fieldMap.forEach((column, field) {
        print('$column : $field');
        query += '$column $field,';
      });

      query = query.substring(0, query.length - 1);
      query += ' )';

      return query;
    }

    Future<String> dbPath() async {
      String path = await getDatabasesPath();
      return path;
    }

    Future<int> insertNote(Bill bill, bool isNew) async {
      // Get a reference to the database
      final Database db = await database;
      print("insert called");

      // Insert the Notes into the correct table.
      await db.insert('bills',
        isNew ? bill.toMap(false) : bill.toMap(true),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (isNew) {
        // get latest note which isn't archived, limit by 1
        var one = await db.query("bills", orderBy: "date_last_edited desc",
            where: "is_archived = ?",
            whereArgs: [0],
            limit: 1);
        int latestId = one.first["id"] as int;
        return latestId;
      }
      return bill.id;
    }


    Future<bool> copyNote(Bill bill) async {
      final Database db = await database;
      try {
        await db.insert("bills", bill.toMap(false),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (Error) {
        print(Error);
        return false;
      }
      return true;
    }


    Future<bool> archiveBill(Bill bill) async {
      if (bill.id != -1) {
        final Database db = await database;

        int idToUpdate = bill.id;

        db.update("bills", bill.toMap(true), where: "id = ?",
            whereArgs: [idToUpdate]);
      }
    }

    Future<bool> deleteBill(Bill bill) async {
      if (bill.id != -1) {
        final Database db = await database;
        try {
          await db.delete("bills", where: "id = ?", whereArgs: [bill.id]);
          return true;
        } catch (Error) {
          print("Error deleting ${bill.id}: ${Error.toString()}");
          return false;
        }
      }
    }


    Future<List<Map<String, dynamic>>> selectAllBills() async {
      final Database db = await database;
      // query all the notes sorted by last edited
      var data = await db.query("bills", orderBy: "date_last_edited desc",
          where: "is_archived = ?",
          whereArgs: [0]);

      return data;
    }
  }