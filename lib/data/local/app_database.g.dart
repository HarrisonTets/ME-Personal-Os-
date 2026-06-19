// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pillarMeta = const VerificationMeta('pillar');
  @override
  late final GeneratedColumn<String> pillar = GeneratedColumn<String>(
    'pillar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _triggerKeyMeta = const VerificationMeta(
    'triggerKey',
  );
  @override
  late final GeneratedColumn<String> triggerKey = GeneratedColumn<String>(
    'trigger_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    pillar,
    difficulty,
    estimatedMinutes,
    active,
    createdAt,
    triggerKey,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('pillar')) {
      context.handle(
        _pillarMeta,
        pillar.isAcceptableOrUnknown(data['pillar']!, _pillarMeta),
      );
    } else if (isInserting) {
      context.missing(_pillarMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('trigger_key')) {
      context.handle(
        _triggerKeyMeta,
        triggerKey.isAcceptableOrUnknown(data['trigger_key']!, _triggerKeyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      pillar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pillar'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      triggerKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_key'],
      ),
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class HabitRow extends DataClass implements Insertable<HabitRow> {
  final String id;
  final String name;
  final String? description;
  final String pillar;
  final String difficulty;
  final int estimatedMinutes;
  final bool active;
  final DateTime createdAt;

  /// Optional cross-pillar link: when a matching activity happens, this habit is
  /// auto-completed on Today. See HabitTriggers.
  final String? triggerKey;
  const HabitRow({
    required this.id,
    required this.name,
    this.description,
    required this.pillar,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.active,
    required this.createdAt,
    this.triggerKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['pillar'] = Variable<String>(pillar);
    map['difficulty'] = Variable<String>(difficulty);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || triggerKey != null) {
      map['trigger_key'] = Variable<String>(triggerKey);
    }
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      pillar: Value(pillar),
      difficulty: Value(difficulty),
      estimatedMinutes: Value(estimatedMinutes),
      active: Value(active),
      createdAt: Value(createdAt),
      triggerKey: triggerKey == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerKey),
    );
  }

  factory HabitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      pillar: serializer.fromJson<String>(json['pillar']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      triggerKey: serializer.fromJson<String?>(json['triggerKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'pillar': serializer.toJson<String>(pillar),
      'difficulty': serializer.toJson<String>(difficulty),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'triggerKey': serializer.toJson<String?>(triggerKey),
    };
  }

  HabitRow copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? pillar,
    String? difficulty,
    int? estimatedMinutes,
    bool? active,
    DateTime? createdAt,
    Value<String?> triggerKey = const Value.absent(),
  }) => HabitRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    pillar: pillar ?? this.pillar,
    difficulty: difficulty ?? this.difficulty,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
    triggerKey: triggerKey.present ? triggerKey.value : this.triggerKey,
  );
  HabitRow copyWithCompanion(HabitsCompanion data) {
    return HabitRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      pillar: data.pillar.present ? data.pillar.value : this.pillar,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      triggerKey: data.triggerKey.present
          ? data.triggerKey.value
          : this.triggerKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('pillar: $pillar, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('triggerKey: $triggerKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    pillar,
    difficulty,
    estimatedMinutes,
    active,
    createdAt,
    triggerKey,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.pillar == this.pillar &&
          other.difficulty == this.difficulty &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.triggerKey == this.triggerKey);
}

class HabitsCompanion extends UpdateCompanion<HabitRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> pillar;
  final Value<String> difficulty;
  final Value<int> estimatedMinutes;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<String?> triggerKey;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.pillar = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.triggerKey = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required String pillar,
    required String difficulty,
    this.estimatedMinutes = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.triggerKey = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       pillar = Value(pillar),
       difficulty = Value(difficulty);
  static Insertable<HabitRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? pillar,
    Expression<String>? difficulty,
    Expression<int>? estimatedMinutes,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<String>? triggerKey,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (pillar != null) 'pillar': pillar,
      if (difficulty != null) 'difficulty': difficulty,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (triggerKey != null) 'trigger_key': triggerKey,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? pillar,
    Value<String>? difficulty,
    Value<int>? estimatedMinutes,
    Value<bool>? active,
    Value<DateTime>? createdAt,
    Value<String?>? triggerKey,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pillar: pillar ?? this.pillar,
      difficulty: difficulty ?? this.difficulty,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      triggerKey: triggerKey ?? this.triggerKey,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pillar.present) {
      map['pillar'] = Variable<String>(pillar.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (triggerKey.present) {
      map['trigger_key'] = Variable<String>(triggerKey.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('pillar: $pillar, ')
          ..write('difficulty: $difficulty, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('triggerKey: $triggerKey, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    date,
    status,
    mood,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }
}

class HabitLogRow extends DataClass implements Insertable<HabitLogRow> {
  final String id;
  final String habitId;
  final DateTime date;
  final String status;
  final String? mood;
  final String? notes;
  const HabitLogRow({
    required this.id,
    required this.habitId,
    required this.date,
    required this.status,
    this.mood,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      date: Value(date),
      status: Value(status),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory HabitLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLogRow(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      mood: serializer.fromJson<String?>(json['mood']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'mood': serializer.toJson<String?>(mood),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  HabitLogRow copyWith({
    String? id,
    String? habitId,
    DateTime? date,
    String? status,
    Value<String?> mood = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => HabitLogRow(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    date: date ?? this.date,
    status: status ?? this.status,
    mood: mood.present ? mood.value : this.mood,
    notes: notes.present ? notes.value : this.notes,
  );
  HabitLogRow copyWithCompanion(HabitLogsCompanion data) {
    return HabitLogRow(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      mood: data.mood.present ? data.mood.value : this.mood,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogRow(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, date, status, mood, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLogRow &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.status == this.status &&
          other.mood == this.mood &&
          other.notes == this.notes);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLogRow> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<String?> mood;
  final Value<String?> notes;
  final Value<int> rowid;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.mood = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    required String id,
    required String habitId,
    required DateTime date,
    required String status,
    this.mood = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       date = Value(date),
       status = Value(status);
  static Insertable<HabitLogRow> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<String>? mood,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (mood != null) 'mood': mood,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<DateTime>? date,
    Value<String>? status,
    Value<String?>? mood,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      status: status ?? this.status,
      mood: mood ?? this.mood,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BiblePlansTable extends BiblePlans
    with TableInfo<$BiblePlansTable, BiblePlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BiblePlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
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
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _totalDaysMeta = const VerificationMeta(
    'totalDays',
  );
  @override
  late final GeneratedColumn<int> totalDays = GeneratedColumn<int>(
    'total_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    totalDays,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<BiblePlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('total_days')) {
      context.handle(
        _totalDaysMeta,
        totalDays.isAcceptableOrUnknown(data['total_days']!, _totalDaysMeta),
      );
    } else if (isInserting) {
      context.missing(_totalDaysMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BiblePlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BiblePlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      totalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_days'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $BiblePlansTable createAlias(String alias) {
    return $BiblePlansTable(attachedDatabase, alias);
  }
}

class BiblePlanRow extends DataClass implements Insertable<BiblePlanRow> {
  final String id;
  final String name;
  final String description;
  final int totalDays;
  final bool active;
  const BiblePlanRow({
    required this.id,
    required this.name,
    required this.description,
    required this.totalDays,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['total_days'] = Variable<int>(totalDays);
    map['active'] = Variable<bool>(active);
    return map;
  }

  BiblePlansCompanion toCompanion(bool nullToAbsent) {
    return BiblePlansCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      totalDays: Value(totalDays),
      active: Value(active),
    );
  }

  factory BiblePlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BiblePlanRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      totalDays: serializer.fromJson<int>(json['totalDays']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'totalDays': serializer.toJson<int>(totalDays),
      'active': serializer.toJson<bool>(active),
    };
  }

  BiblePlanRow copyWith({
    String? id,
    String? name,
    String? description,
    int? totalDays,
    bool? active,
  }) => BiblePlanRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    totalDays: totalDays ?? this.totalDays,
    active: active ?? this.active,
  );
  BiblePlanRow copyWithCompanion(BiblePlansCompanion data) {
    return BiblePlanRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      totalDays: data.totalDays.present ? data.totalDays.value : this.totalDays,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BiblePlanRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('totalDays: $totalDays, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, totalDays, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BiblePlanRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.totalDays == this.totalDays &&
          other.active == this.active);
}

class BiblePlansCompanion extends UpdateCompanion<BiblePlanRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> totalDays;
  final Value<bool> active;
  final Value<int> rowid;
  const BiblePlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.totalDays = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BiblePlansCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required int totalDays,
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       totalDays = Value(totalDays);
  static Insertable<BiblePlanRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? totalDays,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (totalDays != null) 'total_days': totalDays,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BiblePlansCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int>? totalDays,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return BiblePlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      totalDays: totalDays ?? this.totalDays,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (totalDays.present) {
      map['total_days'] = Variable<int>(totalDays.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BiblePlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('totalDays: $totalDays, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingAssignmentsTable extends ReadingAssignments
    with TableInfo<$ReadingAssignmentsTable, ReadingAssignmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bible_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    dayNumber,
    reference,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingAssignmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingAssignmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingAssignmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ReadingAssignmentsTable createAlias(String alias) {
    return $ReadingAssignmentsTable(attachedDatabase, alias);
  }
}

class ReadingAssignmentRow extends DataClass
    implements Insertable<ReadingAssignmentRow> {
  final String id;
  final String planId;
  final int dayNumber;
  final String reference;
  final DateTime? completedAt;
  const ReadingAssignmentRow({
    required this.id,
    required this.planId,
    required this.dayNumber,
    required this.reference,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['day_number'] = Variable<int>(dayNumber);
    map['reference'] = Variable<String>(reference);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ReadingAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return ReadingAssignmentsCompanion(
      id: Value(id),
      planId: Value(planId),
      dayNumber: Value(dayNumber),
      reference: Value(reference),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ReadingAssignmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingAssignmentRow(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      reference: serializer.fromJson<String>(json['reference']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'reference': serializer.toJson<String>(reference),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ReadingAssignmentRow copyWith({
    String? id,
    String? planId,
    int? dayNumber,
    String? reference,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ReadingAssignmentRow(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    dayNumber: dayNumber ?? this.dayNumber,
    reference: reference ?? this.reference,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ReadingAssignmentRow copyWithCompanion(ReadingAssignmentsCompanion data) {
    return ReadingAssignmentRow(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      reference: data.reference.present ? data.reference.value : this.reference,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingAssignmentRow(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('reference: $reference, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, planId, dayNumber, reference, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingAssignmentRow &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.dayNumber == this.dayNumber &&
          other.reference == this.reference &&
          other.completedAt == this.completedAt);
}

class ReadingAssignmentsCompanion
    extends UpdateCompanion<ReadingAssignmentRow> {
  final Value<String> id;
  final Value<String> planId;
  final Value<int> dayNumber;
  final Value<String> reference;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const ReadingAssignmentsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.reference = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingAssignmentsCompanion.insert({
    required String id,
    required String planId,
    required int dayNumber,
    required String reference,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       planId = Value(planId),
       dayNumber = Value(dayNumber),
       reference = Value(reference);
  static Insertable<ReadingAssignmentRow> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<int>? dayNumber,
    Expression<String>? reference,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (dayNumber != null) 'day_number': dayNumber,
      if (reference != null) 'reference': reference,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingAssignmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? planId,
    Value<int>? dayNumber,
    Value<String>? reference,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return ReadingAssignmentsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      dayNumber: dayNumber ?? this.dayNumber,
      reference: reference ?? this.reference,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('reference: $reference, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assignmentIdMeta = const VerificationMeta(
    'assignmentId',
  );
  @override
  late final GeneratedColumn<String> assignmentId = GeneratedColumn<String>(
    'assignment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reference,
    body,
    createdAt,
    assignmentId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('assignment_id')) {
      context.handle(
        _assignmentIdMeta,
        assignmentId.isAcceptableOrUnknown(
          data['assignment_id']!,
          _assignmentIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      assignmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assignment_id'],
      ),
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntryRow extends DataClass implements Insertable<JournalEntryRow> {
  final String id;
  final String reference;
  final String body;
  final DateTime createdAt;
  final String? assignmentId;
  const JournalEntryRow({
    required this.id,
    required this.reference,
    required this.body,
    required this.createdAt,
    this.assignmentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['reference'] = Variable<String>(reference);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || assignmentId != null) {
      map['assignment_id'] = Variable<String>(assignmentId);
    }
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      reference: Value(reference),
      body: Value(body),
      createdAt: Value(createdAt),
      assignmentId: assignmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(assignmentId),
    );
  }

  factory JournalEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntryRow(
      id: serializer.fromJson<String>(json['id']),
      reference: serializer.fromJson<String>(json['reference']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      assignmentId: serializer.fromJson<String?>(json['assignmentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reference': serializer.toJson<String>(reference),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'assignmentId': serializer.toJson<String?>(assignmentId),
    };
  }

  JournalEntryRow copyWith({
    String? id,
    String? reference,
    String? body,
    DateTime? createdAt,
    Value<String?> assignmentId = const Value.absent(),
  }) => JournalEntryRow(
    id: id ?? this.id,
    reference: reference ?? this.reference,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    assignmentId: assignmentId.present ? assignmentId.value : this.assignmentId,
  );
  JournalEntryRow copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntryRow(
      id: data.id.present ? data.id.value : this.id,
      reference: data.reference.present ? data.reference.value : this.reference,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      assignmentId: data.assignmentId.present
          ? data.assignmentId.value
          : this.assignmentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntryRow(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('assignmentId: $assignmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reference, body, createdAt, assignmentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntryRow &&
          other.id == this.id &&
          other.reference == this.reference &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.assignmentId == this.assignmentId);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntryRow> {
  final Value<String> id;
  final Value<String> reference;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<String?> assignmentId;
  final Value<int> rowid;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.reference = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.assignmentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    required String id,
    required String reference,
    required String body,
    required DateTime createdAt,
    this.assignmentId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reference = Value(reference),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<JournalEntryRow> custom({
    Expression<String>? id,
    Expression<String>? reference,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<String>? assignmentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reference != null) 'reference': reference,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (assignmentId != null) 'assignment_id': assignmentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? reference,
    Value<String>? body,
    Value<DateTime>? createdAt,
    Value<String?>? assignmentId,
    Value<int>? rowid,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      assignmentId: assignmentId ?? this.assignmentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (assignmentId.present) {
      map['assignment_id'] = Variable<String>(assignmentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('assignmentId: $assignmentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinanceEntriesTable extends FinanceEntries
    with TableInfo<$FinanceEntriesTable, FinanceEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinanceEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    amount,
    category,
    date,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'finance_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinanceEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinanceEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinanceEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $FinanceEntriesTable createAlias(String alias) {
    return $FinanceEntriesTable(attachedDatabase, alias);
  }
}

class FinanceEntryRow extends DataClass implements Insertable<FinanceEntryRow> {
  final String id;
  final String type;
  final double amount;
  final String category;
  final DateTime date;
  final String? note;
  const FinanceEntryRow({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  FinanceEntriesCompanion toCompanion(bool nullToAbsent) {
    return FinanceEntriesCompanion(
      id: Value(id),
      type: Value(type),
      amount: Value(amount),
      category: Value(category),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory FinanceEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinanceEntryRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
    };
  }

  FinanceEntryRow copyWith({
    String? id,
    String? type,
    double? amount,
    String? category,
    DateTime? date,
    Value<String?> note = const Value.absent(),
  }) => FinanceEntryRow(
    id: id ?? this.id,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
  );
  FinanceEntryRow copyWithCompanion(FinanceEntriesCompanion data) {
    return FinanceEntryRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinanceEntryRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, amount, category, date, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinanceEntryRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.date == this.date &&
          other.note == this.note);
}

class FinanceEntriesCompanion extends UpdateCompanion<FinanceEntryRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<double> amount;
  final Value<String> category;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<int> rowid;
  const FinanceEntriesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinanceEntriesCompanion.insert({
    required String id,
    required String type,
    required double amount,
    required String category,
    required DateTime date,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       amount = Value(amount),
       category = Value(category),
       date = Value(date);
  static Insertable<FinanceEntryRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinanceEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<double>? amount,
    Value<String>? category,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return FinanceEntriesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinanceEntriesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FocusSessionsTable extends FocusSessions
    with TableInfo<$FocusSessionsTable, FocusSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intentionMeta = const VerificationMeta(
    'intention',
  );
  @override
  late final GeneratedColumn<String> intention = GeneratedColumn<String>(
    'intention',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedMinutesMeta = const VerificationMeta(
    'plannedMinutes',
  );
  @override
  late final GeneratedColumn<int> plannedMinutes = GeneratedColumn<int>(
    'planned_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _focusedMinutesMeta = const VerificationMeta(
    'focusedMinutes',
  );
  @override
  late final GeneratedColumn<int> focusedMinutes = GeneratedColumn<int>(
    'focused_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    intention,
    plannedMinutes,
    focusedMinutes,
    completed,
    startedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FocusSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('intention')) {
      context.handle(
        _intentionMeta,
        intention.isAcceptableOrUnknown(data['intention']!, _intentionMeta),
      );
    } else if (isInserting) {
      context.missing(_intentionMeta);
    }
    if (data.containsKey('planned_minutes')) {
      context.handle(
        _plannedMinutesMeta,
        plannedMinutes.isAcceptableOrUnknown(
          data['planned_minutes']!,
          _plannedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedMinutesMeta);
    }
    if (data.containsKey('focused_minutes')) {
      context.handle(
        _focusedMinutesMeta,
        focusedMinutes.isAcceptableOrUnknown(
          data['focused_minutes']!,
          _focusedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_focusedMinutesMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      intention: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intention'],
      )!,
      plannedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_minutes'],
      )!,
      focusedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focused_minutes'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
    );
  }

  @override
  $FocusSessionsTable createAlias(String alias) {
    return $FocusSessionsTable(attachedDatabase, alias);
  }
}

class FocusSessionRow extends DataClass implements Insertable<FocusSessionRow> {
  final String id;
  final String intention;
  final int plannedMinutes;
  final int focusedMinutes;
  final bool completed;
  final DateTime startedAt;
  const FocusSessionRow({
    required this.id,
    required this.intention,
    required this.plannedMinutes,
    required this.focusedMinutes,
    required this.completed,
    required this.startedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['intention'] = Variable<String>(intention);
    map['planned_minutes'] = Variable<int>(plannedMinutes);
    map['focused_minutes'] = Variable<int>(focusedMinutes);
    map['completed'] = Variable<bool>(completed);
    map['started_at'] = Variable<DateTime>(startedAt);
    return map;
  }

  FocusSessionsCompanion toCompanion(bool nullToAbsent) {
    return FocusSessionsCompanion(
      id: Value(id),
      intention: Value(intention),
      plannedMinutes: Value(plannedMinutes),
      focusedMinutes: Value(focusedMinutes),
      completed: Value(completed),
      startedAt: Value(startedAt),
    );
  }

  factory FocusSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusSessionRow(
      id: serializer.fromJson<String>(json['id']),
      intention: serializer.fromJson<String>(json['intention']),
      plannedMinutes: serializer.fromJson<int>(json['plannedMinutes']),
      focusedMinutes: serializer.fromJson<int>(json['focusedMinutes']),
      completed: serializer.fromJson<bool>(json['completed']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'intention': serializer.toJson<String>(intention),
      'plannedMinutes': serializer.toJson<int>(plannedMinutes),
      'focusedMinutes': serializer.toJson<int>(focusedMinutes),
      'completed': serializer.toJson<bool>(completed),
      'startedAt': serializer.toJson<DateTime>(startedAt),
    };
  }

  FocusSessionRow copyWith({
    String? id,
    String? intention,
    int? plannedMinutes,
    int? focusedMinutes,
    bool? completed,
    DateTime? startedAt,
  }) => FocusSessionRow(
    id: id ?? this.id,
    intention: intention ?? this.intention,
    plannedMinutes: plannedMinutes ?? this.plannedMinutes,
    focusedMinutes: focusedMinutes ?? this.focusedMinutes,
    completed: completed ?? this.completed,
    startedAt: startedAt ?? this.startedAt,
  );
  FocusSessionRow copyWithCompanion(FocusSessionsCompanion data) {
    return FocusSessionRow(
      id: data.id.present ? data.id.value : this.id,
      intention: data.intention.present ? data.intention.value : this.intention,
      plannedMinutes: data.plannedMinutes.present
          ? data.plannedMinutes.value
          : this.plannedMinutes,
      focusedMinutes: data.focusedMinutes.present
          ? data.focusedMinutes.value
          : this.focusedMinutes,
      completed: data.completed.present ? data.completed.value : this.completed,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionRow(')
          ..write('id: $id, ')
          ..write('intention: $intention, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('focusedMinutes: $focusedMinutes, ')
          ..write('completed: $completed, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    intention,
    plannedMinutes,
    focusedMinutes,
    completed,
    startedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusSessionRow &&
          other.id == this.id &&
          other.intention == this.intention &&
          other.plannedMinutes == this.plannedMinutes &&
          other.focusedMinutes == this.focusedMinutes &&
          other.completed == this.completed &&
          other.startedAt == this.startedAt);
}

class FocusSessionsCompanion extends UpdateCompanion<FocusSessionRow> {
  final Value<String> id;
  final Value<String> intention;
  final Value<int> plannedMinutes;
  final Value<int> focusedMinutes;
  final Value<bool> completed;
  final Value<DateTime> startedAt;
  final Value<int> rowid;
  const FocusSessionsCompanion({
    this.id = const Value.absent(),
    this.intention = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.focusedMinutes = const Value.absent(),
    this.completed = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FocusSessionsCompanion.insert({
    required String id,
    required String intention,
    required int plannedMinutes,
    required int focusedMinutes,
    required bool completed,
    required DateTime startedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       intention = Value(intention),
       plannedMinutes = Value(plannedMinutes),
       focusedMinutes = Value(focusedMinutes),
       completed = Value(completed),
       startedAt = Value(startedAt);
  static Insertable<FocusSessionRow> custom({
    Expression<String>? id,
    Expression<String>? intention,
    Expression<int>? plannedMinutes,
    Expression<int>? focusedMinutes,
    Expression<bool>? completed,
    Expression<DateTime>? startedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (intention != null) 'intention': intention,
      if (plannedMinutes != null) 'planned_minutes': plannedMinutes,
      if (focusedMinutes != null) 'focused_minutes': focusedMinutes,
      if (completed != null) 'completed': completed,
      if (startedAt != null) 'started_at': startedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FocusSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? intention,
    Value<int>? plannedMinutes,
    Value<int>? focusedMinutes,
    Value<bool>? completed,
    Value<DateTime>? startedAt,
    Value<int>? rowid,
  }) {
    return FocusSessionsCompanion(
      id: id ?? this.id,
      intention: intention ?? this.intention,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      focusedMinutes: focusedMinutes ?? this.focusedMinutes,
      completed: completed ?? this.completed,
      startedAt: startedAt ?? this.startedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (intention.present) {
      map['intention'] = Variable<String>(intention.value);
    }
    if (plannedMinutes.present) {
      map['planned_minutes'] = Variable<int>(plannedMinutes.value);
    }
    if (focusedMinutes.present) {
      map['focused_minutes'] = Variable<int>(focusedMinutes.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionsCompanion(')
          ..write('id: $id, ')
          ..write('intention: $intention, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('focusedMinutes: $focusedMinutes, ')
          ..write('completed: $completed, ')
          ..write('startedAt: $startedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HealthLogsTable extends HealthLogs
    with TableInfo<$HealthLogsTable, HealthLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, value, date, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $HealthLogsTable createAlias(String alias) {
    return $HealthLogsTable(attachedDatabase, alias);
  }
}

class HealthLogRow extends DataClass implements Insertable<HealthLogRow> {
  final String id;
  final String type;
  final double value;
  final DateTime date;
  final String? note;
  const HealthLogRow({
    required this.id,
    required this.type,
    required this.value,
    required this.date,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['value'] = Variable<double>(value);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  HealthLogsCompanion toCompanion(bool nullToAbsent) {
    return HealthLogsCompanion(
      id: Value(id),
      type: Value(type),
      value: Value(value),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory HealthLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthLogRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      value: serializer.fromJson<double>(json['value']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'value': serializer.toJson<double>(value),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
    };
  }

  HealthLogRow copyWith({
    String? id,
    String? type,
    double? value,
    DateTime? date,
    Value<String?> note = const Value.absent(),
  }) => HealthLogRow(
    id: id ?? this.id,
    type: type ?? this.type,
    value: value ?? this.value,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
  );
  HealthLogRow copyWithCompanion(HealthLogsCompanion data) {
    return HealthLogRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthLogRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, value, date, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthLogRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.value == this.value &&
          other.date == this.date &&
          other.note == this.note);
}

class HealthLogsCompanion extends UpdateCompanion<HealthLogRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<double> value;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<int> rowid;
  const HealthLogsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HealthLogsCompanion.insert({
    required String id,
    required String type,
    required double value,
    required DateTime date,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       value = Value(value),
       date = Value(date);
  static Insertable<HealthLogRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<double>? value,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HealthLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<double>? value,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return HealthLogsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      date: date ?? this.date,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthLogsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $BiblePlansTable biblePlans = $BiblePlansTable(this);
  late final $ReadingAssignmentsTable readingAssignments =
      $ReadingAssignmentsTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $FinanceEntriesTable financeEntries = $FinanceEntriesTable(this);
  late final $FocusSessionsTable focusSessions = $FocusSessionsTable(this);
  late final $HealthLogsTable healthLogs = $HealthLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    habitLogs,
    biblePlans,
    readingAssignments,
    journalEntries,
    financeEntries,
    focusSessions,
    healthLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habit_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'bible_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reading_assignments', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      required String pillar,
      required String difficulty,
      Value<int> estimatedMinutes,
      Value<bool> active,
      Value<DateTime> createdAt,
      Value<String?> triggerKey,
      Value<int> rowid,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String> pillar,
      Value<String> difficulty,
      Value<int> estimatedMinutes,
      Value<bool> active,
      Value<DateTime> createdAt,
      Value<String?> triggerKey,
      Value<int> rowid,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, HabitRow> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLogRow>>
  _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogs,
    aliasName: 'habits__id__habit_logs__habit_id',
  );

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager(
      $_db,
      $_db.habitLogs,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pillar => $composableBuilder(
    column: $table.pillar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerKey => $composableBuilder(
    column: $table.triggerKey,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitLogsRefs(
    Expression<bool> Function($$HabitLogsTableFilterComposer f) f,
  ) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableFilterComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pillar => $composableBuilder(
    column: $table.pillar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerKey => $composableBuilder(
    column: $table.triggerKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pillar =>
      $composableBuilder(column: $table.pillar, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get triggerKey => $composableBuilder(
    column: $table.triggerKey,
    builder: (column) => column,
  );

  Expression<T> habitLogsRefs<T extends Object>(
    Expression<T> Function($$HabitLogsTableAnnotationComposer a) f,
  ) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRow,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (HabitRow, $$HabitsTableReferences),
          HabitRow,
          PrefetchHooks Function({bool habitLogsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> pillar = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> triggerKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                description: description,
                pillar: pillar,
                difficulty: difficulty,
                estimatedMinutes: estimatedMinutes,
                active: active,
                createdAt: createdAt,
                triggerKey: triggerKey,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required String pillar,
                required String difficulty,
                Value<int> estimatedMinutes = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> triggerKey = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                description: description,
                pillar: pillar,
                difficulty: difficulty,
                estimatedMinutes: estimatedMinutes,
                active: active,
                createdAt: createdAt,
                triggerKey: triggerKey,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({habitLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitLogsRefs) db.habitLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitLogsRefs)
                    await $_getPrefetchedData<
                      HabitRow,
                      $HabitsTable,
                      HabitLogRow
                    >(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._habitLogsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HabitsTableReferences(db, table, p0).habitLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRow,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRow, $$HabitsTableReferences),
      HabitRow,
      PrefetchHooks Function({bool habitLogsRefs})
    >;
typedef $$HabitLogsTableCreateCompanionBuilder =
    HabitLogsCompanion Function({
      required String id,
      required String habitId,
      required DateTime date,
      required String status,
      Value<String?> mood,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$HabitLogsTableUpdateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<DateTime> date,
      Value<String> status,
      Value<String?> mood,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLogRow> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('habit_logs__habit_id__habits__id');

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitLogsTable,
          HabitLogRow,
          $$HabitLogsTableFilterComposer,
          $$HabitLogsTableOrderingComposer,
          $$HabitLogsTableAnnotationComposer,
          $$HabitLogsTableCreateCompanionBuilder,
          $$HabitLogsTableUpdateCompanionBuilder,
          (HabitLogRow, $$HabitLogsTableReferences),
          HabitLogRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                mood: mood,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required DateTime date,
                required String status,
                Value<String?> mood = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion.insert(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                mood: mood,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$HabitLogsTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$HabitLogsTableReferences
                                    ._habitIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitLogsTable,
      HabitLogRow,
      $$HabitLogsTableFilterComposer,
      $$HabitLogsTableOrderingComposer,
      $$HabitLogsTableAnnotationComposer,
      $$HabitLogsTableCreateCompanionBuilder,
      $$HabitLogsTableUpdateCompanionBuilder,
      (HabitLogRow, $$HabitLogsTableReferences),
      HabitLogRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$BiblePlansTableCreateCompanionBuilder =
    BiblePlansCompanion Function({
      required String id,
      required String name,
      Value<String> description,
      required int totalDays,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$BiblePlansTableUpdateCompanionBuilder =
    BiblePlansCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<int> totalDays,
      Value<bool> active,
      Value<int> rowid,
    });

final class $$BiblePlansTableReferences
    extends BaseReferences<_$AppDatabase, $BiblePlansTable, BiblePlanRow> {
  $$BiblePlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ReadingAssignmentsTable,
    List<ReadingAssignmentRow>
  >
  _readingAssignmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.readingAssignments,
        aliasName: 'bible_plans__id__reading_assignments__plan_id',
      );

  $$ReadingAssignmentsTableProcessedTableManager get readingAssignmentsRefs {
    final manager = $$ReadingAssignmentsTableTableManager(
      $_db,
      $_db.readingAssignments,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BiblePlansTableFilterComposer
    extends Composer<_$AppDatabase, $BiblePlansTable> {
  $$BiblePlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDays => $composableBuilder(
    column: $table.totalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> readingAssignmentsRefs(
    Expression<bool> Function($$ReadingAssignmentsTableFilterComposer f) f,
  ) {
    final $$ReadingAssignmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingAssignments,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingAssignmentsTableFilterComposer(
            $db: $db,
            $table: $db.readingAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BiblePlansTableOrderingComposer
    extends Composer<_$AppDatabase, $BiblePlansTable> {
  $$BiblePlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDays => $composableBuilder(
    column: $table.totalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BiblePlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $BiblePlansTable> {
  $$BiblePlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalDays =>
      $composableBuilder(column: $table.totalDays, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  Expression<T> readingAssignmentsRefs<T extends Object>(
    Expression<T> Function($$ReadingAssignmentsTableAnnotationComposer a) f,
  ) {
    final $$ReadingAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.readingAssignments,
          getReferencedColumn: (t) => t.planId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReadingAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.readingAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BiblePlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BiblePlansTable,
          BiblePlanRow,
          $$BiblePlansTableFilterComposer,
          $$BiblePlansTableOrderingComposer,
          $$BiblePlansTableAnnotationComposer,
          $$BiblePlansTableCreateCompanionBuilder,
          $$BiblePlansTableUpdateCompanionBuilder,
          (BiblePlanRow, $$BiblePlansTableReferences),
          BiblePlanRow,
          PrefetchHooks Function({bool readingAssignmentsRefs})
        > {
  $$BiblePlansTableTableManager(_$AppDatabase db, $BiblePlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BiblePlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BiblePlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BiblePlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> totalDays = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BiblePlansCompanion(
                id: id,
                name: name,
                description: description,
                totalDays: totalDays,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> description = const Value.absent(),
                required int totalDays,
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BiblePlansCompanion.insert(
                id: id,
                name: name,
                description: description,
                totalDays: totalDays,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BiblePlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({readingAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (readingAssignmentsRefs) db.readingAssignments,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (readingAssignmentsRefs)
                    await $_getPrefetchedData<
                      BiblePlanRow,
                      $BiblePlansTable,
                      ReadingAssignmentRow
                    >(
                      currentTable: table,
                      referencedTable: $$BiblePlansTableReferences
                          ._readingAssignmentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BiblePlansTableReferences(
                            db,
                            table,
                            p0,
                          ).readingAssignmentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.planId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BiblePlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BiblePlansTable,
      BiblePlanRow,
      $$BiblePlansTableFilterComposer,
      $$BiblePlansTableOrderingComposer,
      $$BiblePlansTableAnnotationComposer,
      $$BiblePlansTableCreateCompanionBuilder,
      $$BiblePlansTableUpdateCompanionBuilder,
      (BiblePlanRow, $$BiblePlansTableReferences),
      BiblePlanRow,
      PrefetchHooks Function({bool readingAssignmentsRefs})
    >;
typedef $$ReadingAssignmentsTableCreateCompanionBuilder =
    ReadingAssignmentsCompanion Function({
      required String id,
      required String planId,
      required int dayNumber,
      required String reference,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$ReadingAssignmentsTableUpdateCompanionBuilder =
    ReadingAssignmentsCompanion Function({
      Value<String> id,
      Value<String> planId,
      Value<int> dayNumber,
      Value<String> reference,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

final class $$ReadingAssignmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReadingAssignmentsTable,
          ReadingAssignmentRow
        > {
  $$ReadingAssignmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BiblePlansTable _planIdTable(_$AppDatabase db) => db.biblePlans
      .createAlias('reading_assignments__plan_id__bible_plans__id');

  $$BiblePlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$BiblePlansTableTableManager(
      $_db,
      $_db.biblePlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingAssignmentsTable> {
  $$ReadingAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BiblePlansTableFilterComposer get planId {
    final $$BiblePlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.biblePlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePlansTableFilterComposer(
            $db: $db,
            $table: $db.biblePlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingAssignmentsTable> {
  $$ReadingAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BiblePlansTableOrderingComposer get planId {
    final $$BiblePlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.biblePlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePlansTableOrderingComposer(
            $db: $db,
            $table: $db.biblePlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingAssignmentsTable> {
  $$ReadingAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$BiblePlansTableAnnotationComposer get planId {
    final $$BiblePlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.biblePlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiblePlansTableAnnotationComposer(
            $db: $db,
            $table: $db.biblePlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingAssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingAssignmentsTable,
          ReadingAssignmentRow,
          $$ReadingAssignmentsTableFilterComposer,
          $$ReadingAssignmentsTableOrderingComposer,
          $$ReadingAssignmentsTableAnnotationComposer,
          $$ReadingAssignmentsTableCreateCompanionBuilder,
          $$ReadingAssignmentsTableUpdateCompanionBuilder,
          (ReadingAssignmentRow, $$ReadingAssignmentsTableReferences),
          ReadingAssignmentRow,
          PrefetchHooks Function({bool planId})
        > {
  $$ReadingAssignmentsTableTableManager(
    _$AppDatabase db,
    $ReadingAssignmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingAssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingAssignmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingAssignmentsCompanion(
                id: id,
                planId: planId,
                dayNumber: dayNumber,
                reference: reference,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String planId,
                required int dayNumber,
                required String reference,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingAssignmentsCompanion.insert(
                id: id,
                planId: planId,
                dayNumber: dayNumber,
                reference: reference,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReadingAssignmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable:
                                    $$ReadingAssignmentsTableReferences
                                        ._planIdTable(db),
                                referencedColumn:
                                    $$ReadingAssignmentsTableReferences
                                        ._planIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingAssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingAssignmentsTable,
      ReadingAssignmentRow,
      $$ReadingAssignmentsTableFilterComposer,
      $$ReadingAssignmentsTableOrderingComposer,
      $$ReadingAssignmentsTableAnnotationComposer,
      $$ReadingAssignmentsTableCreateCompanionBuilder,
      $$ReadingAssignmentsTableUpdateCompanionBuilder,
      (ReadingAssignmentRow, $$ReadingAssignmentsTableReferences),
      ReadingAssignmentRow,
      PrefetchHooks Function({bool planId})
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      required String id,
      required String reference,
      required String body,
      required DateTime createdAt,
      Value<String?> assignmentId,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<String> id,
      Value<String> reference,
      Value<String> body,
      Value<DateTime> createdAt,
      Value<String?> assignmentId,
      Value<int> rowid,
    });

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignmentId => $composableBuilder(
    column: $table.assignmentId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignmentId => $composableBuilder(
    column: $table.assignmentId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get assignmentId => $composableBuilder(
    column: $table.assignmentId,
    builder: (column) => column,
  );
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntryRow,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (
            JournalEntryRow,
            BaseReferences<
              _$AppDatabase,
              $JournalEntriesTable,
              JournalEntryRow
            >,
          ),
          JournalEntryRow,
          PrefetchHooks Function()
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> assignmentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                reference: reference,
                body: body,
                createdAt: createdAt,
                assignmentId: assignmentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reference,
                required String body,
                required DateTime createdAt,
                Value<String?> assignmentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                id: id,
                reference: reference,
                body: body,
                createdAt: createdAt,
                assignmentId: assignmentId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntryRow,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (
        JournalEntryRow,
        BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntryRow>,
      ),
      JournalEntryRow,
      PrefetchHooks Function()
    >;
typedef $$FinanceEntriesTableCreateCompanionBuilder =
    FinanceEntriesCompanion Function({
      required String id,
      required String type,
      required double amount,
      required String category,
      required DateTime date,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$FinanceEntriesTableUpdateCompanionBuilder =
    FinanceEntriesCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<double> amount,
      Value<String> category,
      Value<DateTime> date,
      Value<String?> note,
      Value<int> rowid,
    });

class $$FinanceEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FinanceEntriesTable> {
  $$FinanceEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FinanceEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FinanceEntriesTable> {
  $$FinanceEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinanceEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinanceEntriesTable> {
  $$FinanceEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$FinanceEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinanceEntriesTable,
          FinanceEntryRow,
          $$FinanceEntriesTableFilterComposer,
          $$FinanceEntriesTableOrderingComposer,
          $$FinanceEntriesTableAnnotationComposer,
          $$FinanceEntriesTableCreateCompanionBuilder,
          $$FinanceEntriesTableUpdateCompanionBuilder,
          (
            FinanceEntryRow,
            BaseReferences<
              _$AppDatabase,
              $FinanceEntriesTable,
              FinanceEntryRow
            >,
          ),
          FinanceEntryRow,
          PrefetchHooks Function()
        > {
  $$FinanceEntriesTableTableManager(
    _$AppDatabase db,
    $FinanceEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinanceEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinanceEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinanceEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinanceEntriesCompanion(
                id: id,
                type: type,
                amount: amount,
                category: category,
                date: date,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required double amount,
                required String category,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinanceEntriesCompanion.insert(
                id: id,
                type: type,
                amount: amount,
                category: category,
                date: date,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FinanceEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinanceEntriesTable,
      FinanceEntryRow,
      $$FinanceEntriesTableFilterComposer,
      $$FinanceEntriesTableOrderingComposer,
      $$FinanceEntriesTableAnnotationComposer,
      $$FinanceEntriesTableCreateCompanionBuilder,
      $$FinanceEntriesTableUpdateCompanionBuilder,
      (
        FinanceEntryRow,
        BaseReferences<_$AppDatabase, $FinanceEntriesTable, FinanceEntryRow>,
      ),
      FinanceEntryRow,
      PrefetchHooks Function()
    >;
typedef $$FocusSessionsTableCreateCompanionBuilder =
    FocusSessionsCompanion Function({
      required String id,
      required String intention,
      required int plannedMinutes,
      required int focusedMinutes,
      required bool completed,
      required DateTime startedAt,
      Value<int> rowid,
    });
typedef $$FocusSessionsTableUpdateCompanionBuilder =
    FocusSessionsCompanion Function({
      Value<String> id,
      Value<String> intention,
      Value<int> plannedMinutes,
      Value<int> focusedMinutes,
      Value<bool> completed,
      Value<DateTime> startedAt,
      Value<int> rowid,
    });

class $$FocusSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusedMinutes => $composableBuilder(
    column: $table.focusedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FocusSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusedMinutes => $composableBuilder(
    column: $table.focusedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FocusSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get intention =>
      $composableBuilder(column: $table.intention, builder: (column) => column);

  GeneratedColumn<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get focusedMinutes => $composableBuilder(
    column: $table.focusedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);
}

class $$FocusSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FocusSessionsTable,
          FocusSessionRow,
          $$FocusSessionsTableFilterComposer,
          $$FocusSessionsTableOrderingComposer,
          $$FocusSessionsTableAnnotationComposer,
          $$FocusSessionsTableCreateCompanionBuilder,
          $$FocusSessionsTableUpdateCompanionBuilder,
          (
            FocusSessionRow,
            BaseReferences<_$AppDatabase, $FocusSessionsTable, FocusSessionRow>,
          ),
          FocusSessionRow,
          PrefetchHooks Function()
        > {
  $$FocusSessionsTableTableManager(_$AppDatabase db, $FocusSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> intention = const Value.absent(),
                Value<int> plannedMinutes = const Value.absent(),
                Value<int> focusedMinutes = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FocusSessionsCompanion(
                id: id,
                intention: intention,
                plannedMinutes: plannedMinutes,
                focusedMinutes: focusedMinutes,
                completed: completed,
                startedAt: startedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String intention,
                required int plannedMinutes,
                required int focusedMinutes,
                required bool completed,
                required DateTime startedAt,
                Value<int> rowid = const Value.absent(),
              }) => FocusSessionsCompanion.insert(
                id: id,
                intention: intention,
                plannedMinutes: plannedMinutes,
                focusedMinutes: focusedMinutes,
                completed: completed,
                startedAt: startedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FocusSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FocusSessionsTable,
      FocusSessionRow,
      $$FocusSessionsTableFilterComposer,
      $$FocusSessionsTableOrderingComposer,
      $$FocusSessionsTableAnnotationComposer,
      $$FocusSessionsTableCreateCompanionBuilder,
      $$FocusSessionsTableUpdateCompanionBuilder,
      (
        FocusSessionRow,
        BaseReferences<_$AppDatabase, $FocusSessionsTable, FocusSessionRow>,
      ),
      FocusSessionRow,
      PrefetchHooks Function()
    >;
typedef $$HealthLogsTableCreateCompanionBuilder =
    HealthLogsCompanion Function({
      required String id,
      required String type,
      required double value,
      required DateTime date,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$HealthLogsTableUpdateCompanionBuilder =
    HealthLogsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<double> value,
      Value<DateTime> date,
      Value<String?> note,
      Value<int> rowid,
    });

class $$HealthLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HealthLogsTable> {
  $$HealthLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthLogsTable> {
  $$HealthLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthLogsTable> {
  $$HealthLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$HealthLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthLogsTable,
          HealthLogRow,
          $$HealthLogsTableFilterComposer,
          $$HealthLogsTableOrderingComposer,
          $$HealthLogsTableAnnotationComposer,
          $$HealthLogsTableCreateCompanionBuilder,
          $$HealthLogsTableUpdateCompanionBuilder,
          (
            HealthLogRow,
            BaseReferences<_$AppDatabase, $HealthLogsTable, HealthLogRow>,
          ),
          HealthLogRow,
          PrefetchHooks Function()
        > {
  $$HealthLogsTableTableManager(_$AppDatabase db, $HealthLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HealthLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthLogsCompanion(
                id: id,
                type: type,
                value: value,
                date: date,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required double value,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthLogsCompanion.insert(
                id: id,
                type: type,
                value: value,
                date: date,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthLogsTable,
      HealthLogRow,
      $$HealthLogsTableFilterComposer,
      $$HealthLogsTableOrderingComposer,
      $$HealthLogsTableAnnotationComposer,
      $$HealthLogsTableCreateCompanionBuilder,
      $$HealthLogsTableUpdateCompanionBuilder,
      (
        HealthLogRow,
        BaseReferences<_$AppDatabase, $HealthLogsTable, HealthLogRow>,
      ),
      HealthLogRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$BiblePlansTableTableManager get biblePlans =>
      $$BiblePlansTableTableManager(_db, _db.biblePlans);
  $$ReadingAssignmentsTableTableManager get readingAssignments =>
      $$ReadingAssignmentsTableTableManager(_db, _db.readingAssignments);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$FinanceEntriesTableTableManager get financeEntries =>
      $$FinanceEntriesTableTableManager(_db, _db.financeEntries);
  $$FocusSessionsTableTableManager get focusSessions =>
      $$FocusSessionsTableTableManager(_db, _db.focusSessions);
  $$HealthLogsTableTableManager get healthLogs =>
      $$HealthLogsTableTableManager(_db, _db.healthLogs);
}
