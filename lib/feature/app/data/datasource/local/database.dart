import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  AppDatabase._internal();

  factory AppDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ecommerce.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Cart (
        id TEXT PRIMARY KEY,
        userId TEXT,
        productId TEXT,
        productName TEXT,
        productImage TEXT,
        productPrice INTEGER,
        categoryId INTEGER,
        categoryName TEXT,
        quantity INTEGER,
        size TEXT,
        color TEXT,
        createdAt INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE Notification (
        id TEXT PRIMARY KEY,
        content TEXT,
        fullName TEXT,
        profileImage TEXT,
        createdAt TEXT,
        userId TEXT,
        isRead INTEGER
      )
    ''');
  }
}
