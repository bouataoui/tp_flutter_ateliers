// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// ignore_for_file: type=lint
class $ProduitsTableTable extends ProduitsTable
    with TableInfo<$ProduitsTableTable, ProduitsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProduitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prixMeta = const VerificationMeta('prix');
  @override
  late final GeneratedColumn<double> prix = GeneratedColumn<double>(
    'prix',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, libelle, description, prix, photo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produits_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProduitsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('prix')) {
      context.handle(
        _prixMeta,
        prix.isAcceptableOrUnknown(data['prix']!, _prixMeta),
      );
    } else if (isInserting) {
      context.missing(_prixMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProduitsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProduitsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      prix: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prix'],
      )!,
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      ),
    );
  }

  @override
  $ProduitsTableTable createAlias(String alias) {
    return $ProduitsTableTable(attachedDatabase, alias);
  }
}

class ProduitsTableData extends DataClass
    implements Insertable<ProduitsTableData> {
  final int id;
  final String libelle;
  final String description;
  final double prix;
  final String? photo;
  const ProduitsTableData({
    required this.id,
    required this.libelle,
    required this.description,
    required this.prix,
    this.photo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['libelle'] = Variable<String>(libelle);
    map['description'] = Variable<String>(description);
    map['prix'] = Variable<double>(prix);
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    return map;
  }

  ProduitsTableCompanion toCompanion(bool nullToAbsent) {
    return ProduitsTableCompanion(
      id: Value(id),
      libelle: Value(libelle),
      description: Value(description),
      prix: Value(prix),
      photo: photo == null && nullToAbsent
          ? const Value.absent()
          : Value(photo),
    );
  }

  factory ProduitsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProduitsTableData(
      id: serializer.fromJson<int>(json['id']),
      libelle: serializer.fromJson<String>(json['libelle']),
      description: serializer.fromJson<String>(json['description']),
      prix: serializer.fromJson<double>(json['prix']),
      photo: serializer.fromJson<String?>(json['photo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'libelle': serializer.toJson<String>(libelle),
      'description': serializer.toJson<String>(description),
      'prix': serializer.toJson<double>(prix),
      'photo': serializer.toJson<String?>(photo),
    };
  }

  ProduitsTableData copyWith({
    int? id,
    String? libelle,
    String? description,
    double? prix,
    Value<String?> photo = const Value.absent(),
  }) => ProduitsTableData(
    id: id ?? this.id,
    libelle: libelle ?? this.libelle,
    description: description ?? this.description,
    prix: prix ?? this.prix,
    photo: photo.present ? photo.value : this.photo,
  );
  ProduitsTableData copyWithCompanion(ProduitsTableCompanion data) {
    return ProduitsTableData(
      id: data.id.present ? data.id.value : this.id,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      description: data.description.present
          ? data.description.value
          : this.description,
      prix: data.prix.present ? data.prix.value : this.prix,
      photo: data.photo.present ? data.photo.value : this.photo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProduitsTableData(')
          ..write('id: $id, ')
          ..write('libelle: $libelle, ')
          ..write('description: $description, ')
          ..write('prix: $prix, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, libelle, description, prix, photo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProduitsTableData &&
          other.id == this.id &&
          other.libelle == this.libelle &&
          other.description == this.description &&
          other.prix == this.prix &&
          other.photo == this.photo);
}

class ProduitsTableCompanion extends UpdateCompanion<ProduitsTableData> {
  final Value<int> id;
  final Value<String> libelle;
  final Value<String> description;
  final Value<double> prix;
  final Value<String?> photo;
  const ProduitsTableCompanion({
    this.id = const Value.absent(),
    this.libelle = const Value.absent(),
    this.description = const Value.absent(),
    this.prix = const Value.absent(),
    this.photo = const Value.absent(),
  });
  ProduitsTableCompanion.insert({
    this.id = const Value.absent(),
    required String libelle,
    required String description,
    required double prix,
    this.photo = const Value.absent(),
  }) : libelle = Value(libelle),
       description = Value(description),
       prix = Value(prix);
  static Insertable<ProduitsTableData> custom({
    Expression<int>? id,
    Expression<String>? libelle,
    Expression<String>? description,
    Expression<double>? prix,
    Expression<String>? photo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libelle != null) 'libelle': libelle,
      if (description != null) 'description': description,
      if (prix != null) 'prix': prix,
      if (photo != null) 'photo': photo,
    });
  }

  ProduitsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? libelle,
    Value<String>? description,
    Value<double>? prix,
    Value<String?>? photo,
  }) {
    return ProduitsTableCompanion(
      id: id ?? this.id,
      libelle: libelle ?? this.libelle,
      description: description ?? this.description,
      prix: prix ?? this.prix,
      photo: photo ?? this.photo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (prix.present) {
      map['prix'] = Variable<double>(prix.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProduitsTableCompanion(')
          ..write('id: $id, ')
          ..write('libelle: $libelle, ')
          ..write('description: $description, ')
          ..write('prix: $prix, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProduitsDatabase extends GeneratedDatabase {
  _$ProduitsDatabase(QueryExecutor e) : super(e);
  $ProduitsDatabaseManager get managers => $ProduitsDatabaseManager(this);
  late final $ProduitsTableTable produitsTable = $ProduitsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [produitsTable];
}

typedef $$ProduitsTableTableCreateCompanionBuilder =
    ProduitsTableCompanion Function({
      Value<int> id,
      required String libelle,
      required String description,
      required double prix,
      Value<String?> photo,
    });
typedef $$ProduitsTableTableUpdateCompanionBuilder =
    ProduitsTableCompanion Function({
      Value<int> id,
      Value<String> libelle,
      Value<String> description,
      Value<double> prix,
      Value<String?> photo,
    });

class $$ProduitsTableTableFilterComposer
    extends Composer<_$ProduitsDatabase, $ProduitsTableTable> {
  $$ProduitsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prix => $composableBuilder(
    column: $table.prix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProduitsTableTableOrderingComposer
    extends Composer<_$ProduitsDatabase, $ProduitsTableTable> {
  $$ProduitsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prix => $composableBuilder(
    column: $table.prix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProduitsTableTableAnnotationComposer
    extends Composer<_$ProduitsDatabase, $ProduitsTableTable> {
  $$ProduitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get prix =>
      $composableBuilder(column: $table.prix, builder: (column) => column);

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);
}

class $$ProduitsTableTableTableManager
    extends
        RootTableManager<
          _$ProduitsDatabase,
          $ProduitsTableTable,
          ProduitsTableData,
          $$ProduitsTableTableFilterComposer,
          $$ProduitsTableTableOrderingComposer,
          $$ProduitsTableTableAnnotationComposer,
          $$ProduitsTableTableCreateCompanionBuilder,
          $$ProduitsTableTableUpdateCompanionBuilder,
          (
            ProduitsTableData,
            BaseReferences<
              _$ProduitsDatabase,
              $ProduitsTableTable,
              ProduitsTableData
            >,
          ),
          ProduitsTableData,
          PrefetchHooks Function()
        > {
  $$ProduitsTableTableTableManager(
    _$ProduitsDatabase db,
    $ProduitsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProduitsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProduitsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProduitsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> prix = const Value.absent(),
                Value<String?> photo = const Value.absent(),
              }) => ProduitsTableCompanion(
                id: id,
                libelle: libelle,
                description: description,
                prix: prix,
                photo: photo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String libelle,
                required String description,
                required double prix,
                Value<String?> photo = const Value.absent(),
              }) => ProduitsTableCompanion.insert(
                id: id,
                libelle: libelle,
                description: description,
                prix: prix,
                photo: photo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProduitsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$ProduitsDatabase,
      $ProduitsTableTable,
      ProduitsTableData,
      $$ProduitsTableTableFilterComposer,
      $$ProduitsTableTableOrderingComposer,
      $$ProduitsTableTableAnnotationComposer,
      $$ProduitsTableTableCreateCompanionBuilder,
      $$ProduitsTableTableUpdateCompanionBuilder,
      (
        ProduitsTableData,
        BaseReferences<
          _$ProduitsDatabase,
          $ProduitsTableTable,
          ProduitsTableData
        >,
      ),
      ProduitsTableData,
      PrefetchHooks Function()
    >;

class $ProduitsDatabaseManager {
  final _$ProduitsDatabase _db;
  $ProduitsDatabaseManager(this._db);
  $$ProduitsTableTableTableManager get produitsTable =>
      $$ProduitsTableTableTableManager(_db, _db.produitsTable);
}
