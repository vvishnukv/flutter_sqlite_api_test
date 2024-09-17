import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'api_service.dart';

class DatabaseHelper {
  static final _databaseName = "PostsDatabase.db";
  static final _databaseVersion = 1;
  static final table = 'posts';

  static final columnId = 'id';
  static final columnUserId = 'userId';
  static final columnTitle = 'title';
  static final columnBody = 'body';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnUserId INTEGER NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnBody TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertPost(Post post) async {
    Database db = await instance.database;

    // Check if the post with the same id already exists
    final List<Map<String, dynamic>> existingPosts = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [post.id],
    );

    if (existingPosts.isNotEmpty) {
      // If exists, update the existing post
      await db.update(
        table,
        {
          columnUserId: post.userId,
          columnTitle: post.title,
          columnBody: post.body,
        },
        where: '$columnId = ?',
        whereArgs: [post.id],
      );
    } else {
      // If not exists, insert a new post
      await db.insert(table, {
        columnId: post.id,
        columnUserId: post.userId,
        columnTitle: post.title,
        columnBody: post.body,
      });
    }
  }


  Future<List<Post>> fetchPosts() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        title: maps[i]['title'],
        body: maps[i]['body'],
      );
    });
  }
}

