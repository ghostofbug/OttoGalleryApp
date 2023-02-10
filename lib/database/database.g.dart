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

  PhotoDao? _imageDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `FAVOURITE_PHOTO` (`id` TEXT, `code` TEXT, `name` TEXT, `width` REAL, `height` REAL, `description` TEXT, `createdAt` TEXT, `updatedAt` TEXT, `blurHash` TEXT, `favouriteAddDate` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FAVOURITE_IMAGE_URLS` (`id` TEXT, `raw` TEXT, `full` TEXT, `regular` TEXT, `small` TEXT, `thumb` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PhotoDao get imageDao {
    return _imageDaoInstance ??= _$PhotoDao(database, changeListener);
  }

  @override
  ImageUrlDao get imageUrlDao {
    return _imageUrlDaoInstance ??= _$ImageUrlDao(database, changeListener);
  }
}

class _$PhotoDao extends PhotoDao {
  _$PhotoDao(
    this.database,
    this.changeListener,
  )   : _photoInsertionAdapter = InsertionAdapter(
            database,
            'FAVOURITE_PHOTO',
            (Photo item) => <String, Object?>{
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
        _photoDeletionAdapter = DeletionAdapter(
            database,
            'FAVOURITE_PHOTO',
            ['id'],
            (Photo item) => <String, Object?>{
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

  final InsertionAdapter<Photo> _photoInsertionAdapter;

  final DeletionAdapter<Photo> _photoDeletionAdapter;

  @override
  Future<void> insertFavouritePhoto(Photo photo) async {
    await _photoInsertionAdapter.insert(photo, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteFavouritePhoto(Photo photo) async {
    await _photoDeletionAdapter.delete(photo);
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
