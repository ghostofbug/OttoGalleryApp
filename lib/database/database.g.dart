// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ImageDao? _imageDaoInstance;

  ImageUrlDao? _imageUrlDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FAVOURITE_IMAGE` (`id` TEXT, `code` TEXT, `name` TEXT, `width` REAL, `height` REAL, `description` TEXT, `createdAt` TEXT, `updatedAt` TEXT, `blurHash` TEXT, `favouriteAddDate` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FAVOURITE_IMAGE_URLS` (`id` TEXT, `raw` TEXT, `full` TEXT, `regular` TEXT, `small` TEXT, `thumb` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ImageDao get imageDao {
    return _imageDaoInstance ??= _$ImageDao(database, changeListener);
  }

  @override
  ImageUrlDao get imageUrlDao {
    return _imageUrlDaoInstance ??= _$ImageUrlDao(database, changeListener);
  }
}

class _$ImageDao extends ImageDao {
  _$ImageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _imageDatasetInsertionAdapter = InsertionAdapter(
            database,
            'FAVOURITE_IMAGE',
            (ImageDataset item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name,
                  'width': item.width,
                  'height': item.height,
                  'description': item.description,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'blurHash': item.blurHash,
                  'favouriteAddDate': item.favouriteAddDate
                }),
        _imageDatasetDeletionAdapter = DeletionAdapter(
            database,
            'FAVOURITE_IMAGE',
            ['id'],
            (ImageDataset item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name,
                  'width': item.width,
                  'height': item.height,
                  'description': item.description,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'blurHash': item.blurHash,
                  'favouriteAddDate': item.favouriteAddDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ImageDataset> _imageDatasetInsertionAdapter;

  final DeletionAdapter<ImageDataset> _imageDatasetDeletionAdapter;

  @override
  Future<List<ImageDataset>> getAllFavouriteImage() async {
    return _queryAdapter.queryList('SELECT * FROM FAVOURITE_IMAGE',
        mapper: (Map<String, Object?> row) => ImageDataset(
            code: row['code'] as String?,
            id: row['id'] as String?,
            createdAt: row['createdAt'] as String?,
            description: row['description'] as String?,
            favouriteAddDate: row['favouriteAddDate'] as int?,
            height: row['height'] as double?,
            name: row['name'] as String?,
            updatedAt: row['updatedAt'] as String?,
            blurHash: row['blurHash'] as String?,
            width: row['width'] as double?));
  }

  @override
  Future<void> insertFavouriteImage(ImageDataset imageDataset) async {
    await _imageDatasetInsertionAdapter.insert(
        imageDataset, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteFavouriteImage(ImageDataset image) async {
    await _imageDatasetDeletionAdapter.delete(image);
  }
}

class _$ImageUrlDao extends ImageUrlDao {
  _$ImageUrlDao(
    this.database,
    this.changeListener,
  ) : _imageUrlInsertionAdapter = InsertionAdapter(
            database,
            'FAVOURITE_IMAGE_URLS',
            (ImageUrl item) => <String, Object?>{
                  'id': item.id,
                  'raw': item.raw,
                  'full': item.full,
                  'regular': item.regular,
                  'small': item.small,
                  'thumb': item.thumb
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<ImageUrl> _imageUrlInsertionAdapter;

  @override
  Future<void> insertFavouriteImageUrl(ImageUrl imageUrl) async {
    await _imageUrlInsertionAdapter.insert(
        imageUrl, OnConflictStrategy.replace);
  }
}
