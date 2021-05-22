// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tm_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorTMDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TMDatabaseBuilder databaseBuilder(String name) =>
      _$TMDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TMDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TMDatabaseBuilder(null);
}

class _$TMDatabaseBuilder {
  _$TMDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$TMDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TMDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TMDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$TMDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TMDatabase extends TMDatabase {
  _$TMDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TMLocalDatasource _mainDatasourceInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `BeaconLocalModel` (`uuid` TEXT, `name` TEXT, PRIMARY KEY (`uuid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TMLocalDatasource get mainDatasource {
    return _mainDatasourceInstance ??=
        _$TMLocalDatasource(database, changeListener);
  }
}

class _$TMLocalDatasource extends TMLocalDatasource {
  _$TMLocalDatasource(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _beaconLocalModelInsertionAdapter = InsertionAdapter(
            database,
            'BeaconLocalModel',
            (BeaconLocalModel item) =>
                <String, dynamic>{'uuid': item.uuid, 'name': item.name}),
        _beaconLocalModelUpdateAdapter = UpdateAdapter(
            database,
            'BeaconLocalModel',
            ['uuid'],
            (BeaconLocalModel item) =>
                <String, dynamic>{'uuid': item.uuid, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BeaconLocalModel> _beaconLocalModelInsertionAdapter;

  final UpdateAdapter<BeaconLocalModel> _beaconLocalModelUpdateAdapter;

  @override
  Future<List<BeaconLocalModel>> getAllBeacons() async {
    return _queryAdapter.queryList('SELECT * FROM beacons',
        mapper: (Map<String, dynamic> row) =>
            BeaconLocalModel(row['uuid'] as String, row['name'] as String));
  }

  @override
  Future<List<BeaconLocalModel>> watchAllBeacons() async {
    return _queryAdapter.queryList('SELECT * FROM beacons',
        mapper: (Map<String, dynamic> row) =>
            BeaconLocalModel(row['uuid'] as String, row['name'] as String));
  }

  @override
  Future<void> insertBeacons(List<BeaconLocalModel> memosLocalModels) async {
    await _beaconLocalModelInsertionAdapter.insertList(
        memosLocalModels, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateBeacon(BeaconLocalModel memoLocalModel) async {
    await _beaconLocalModelUpdateAdapter.update(
        memoLocalModel, OnConflictStrategy.replace);
  }
}
