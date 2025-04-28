import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DBService {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            image TEXT,
            price REAL
          )
        ''');
      },
    );
  }

  static Future<void> insertProducts(List<Product> products) async {
    final database = await db;
    Batch batch = database.batch();
    for (var product in products) {
      batch.insert('products', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  static Future<List<Product>> getProducts() async {
    final database = await db;
    final List<Map<String, dynamic>> maps = await database.query('products');
    return maps.map((e) => Product.fromJson(e)).toList();
  }
}
