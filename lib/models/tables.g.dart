// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// ignore_for_file: type=lint
class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _plateNumberMeta = const VerificationMeta(
    'plateNumber',
  );
  @override
  late final GeneratedColumn<String> plateNumber = GeneratedColumn<String>(
    'plate_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelPassQrMeta = const VerificationMeta(
    'fuelPassQr',
  );
  @override
  late final GeneratedColumn<String> fuelPassQr = GeneratedColumn<String>(
    'fuel_pass_qr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weeklyQuotaLMeta = const VerificationMeta(
    'weeklyQuotaL',
  );
  @override
  late final GeneratedColumn<double> weeklyQuotaL = GeneratedColumn<double>(
    'weekly_quota_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20.0),
  );
  static const VerificationMeta _remainingQuotaLMeta = const VerificationMeta(
    'remainingQuotaL',
  );
  @override
  late final GeneratedColumn<double> remainingQuotaL = GeneratedColumn<double>(
    'remaining_quota_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20.0),
  );
  static const VerificationMeta _quotaResetAtMeta = const VerificationMeta(
    'quotaResetAt',
  );
  @override
  late final GeneratedColumn<int> quotaResetAt = GeneratedColumn<int>(
    'quota_reset_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _currentOdometerKmMeta = const VerificationMeta(
    'currentOdometerKm',
  );
  @override
  late final GeneratedColumn<int> currentOdometerKm = GeneratedColumn<int>(
    'current_odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avgKmPerDayMeta = const VerificationMeta(
    'avgKmPerDay',
  );
  @override
  late final GeneratedColumn<double> avgKmPerDay = GeneratedColumn<double>(
    'avg_km_per_day',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(30.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    plateNumber,
    make,
    model,
    fuelPassQr,
    weeklyQuotaL,
    remainingQuotaL,
    quotaResetAt,
    isActive,
    currentOdometerKm,
    avgKmPerDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plate_number')) {
      context.handle(
        _plateNumberMeta,
        plateNumber.isAcceptableOrUnknown(
          data['plate_number']!,
          _plateNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plateNumberMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('fuel_pass_qr')) {
      context.handle(
        _fuelPassQrMeta,
        fuelPassQr.isAcceptableOrUnknown(
          data['fuel_pass_qr']!,
          _fuelPassQrMeta,
        ),
      );
    }
    if (data.containsKey('weekly_quota_l')) {
      context.handle(
        _weeklyQuotaLMeta,
        weeklyQuotaL.isAcceptableOrUnknown(
          data['weekly_quota_l']!,
          _weeklyQuotaLMeta,
        ),
      );
    }
    if (data.containsKey('remaining_quota_l')) {
      context.handle(
        _remainingQuotaLMeta,
        remainingQuotaL.isAcceptableOrUnknown(
          data['remaining_quota_l']!,
          _remainingQuotaLMeta,
        ),
      );
    }
    if (data.containsKey('quota_reset_at')) {
      context.handle(
        _quotaResetAtMeta,
        quotaResetAt.isAcceptableOrUnknown(
          data['quota_reset_at']!,
          _quotaResetAtMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('current_odometer_km')) {
      context.handle(
        _currentOdometerKmMeta,
        currentOdometerKm.isAcceptableOrUnknown(
          data['current_odometer_km']!,
          _currentOdometerKmMeta,
        ),
      );
    }
    if (data.containsKey('avg_km_per_day')) {
      context.handle(
        _avgKmPerDayMeta,
        avgKmPerDay.isAcceptableOrUnknown(
          data['avg_km_per_day']!,
          _avgKmPerDayMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      plateNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_number'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      fuelPassQr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_pass_qr'],
      ),
      weeklyQuotaL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weekly_quota_l'],
      )!,
      remainingQuotaL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_quota_l'],
      )!,
      quotaResetAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quota_reset_at'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      currentOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_odometer_km'],
      )!,
      avgKmPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_km_per_day'],
      )!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final int id;
  final String plateNumber;
  final String? make;
  final String? model;
  final String? fuelPassQr;
  final double weeklyQuotaL;
  final double remainingQuotaL;
  final int? quotaResetAt;
  final bool isActive;
  final int currentOdometerKm;
  final double avgKmPerDay;
  const Vehicle({
    required this.id,
    required this.plateNumber,
    this.make,
    this.model,
    this.fuelPassQr,
    required this.weeklyQuotaL,
    required this.remainingQuotaL,
    this.quotaResetAt,
    required this.isActive,
    required this.currentOdometerKm,
    required this.avgKmPerDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plate_number'] = Variable<String>(plateNumber);
    if (!nullToAbsent || make != null) {
      map['make'] = Variable<String>(make);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || fuelPassQr != null) {
      map['fuel_pass_qr'] = Variable<String>(fuelPassQr);
    }
    map['weekly_quota_l'] = Variable<double>(weeklyQuotaL);
    map['remaining_quota_l'] = Variable<double>(remainingQuotaL);
    if (!nullToAbsent || quotaResetAt != null) {
      map['quota_reset_at'] = Variable<int>(quotaResetAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['current_odometer_km'] = Variable<int>(currentOdometerKm);
    map['avg_km_per_day'] = Variable<double>(avgKmPerDay);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      plateNumber: Value(plateNumber),
      make: make == null && nullToAbsent ? const Value.absent() : Value(make),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      fuelPassQr: fuelPassQr == null && nullToAbsent
          ? const Value.absent()
          : Value(fuelPassQr),
      weeklyQuotaL: Value(weeklyQuotaL),
      remainingQuotaL: Value(remainingQuotaL),
      quotaResetAt: quotaResetAt == null && nullToAbsent
          ? const Value.absent()
          : Value(quotaResetAt),
      isActive: Value(isActive),
      currentOdometerKm: Value(currentOdometerKm),
      avgKmPerDay: Value(avgKmPerDay),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<int>(json['id']),
      plateNumber: serializer.fromJson<String>(json['plateNumber']),
      make: serializer.fromJson<String?>(json['make']),
      model: serializer.fromJson<String?>(json['model']),
      fuelPassQr: serializer.fromJson<String?>(json['fuelPassQr']),
      weeklyQuotaL: serializer.fromJson<double>(json['weeklyQuotaL']),
      remainingQuotaL: serializer.fromJson<double>(json['remainingQuotaL']),
      quotaResetAt: serializer.fromJson<int?>(json['quotaResetAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      currentOdometerKm: serializer.fromJson<int>(json['currentOdometerKm']),
      avgKmPerDay: serializer.fromJson<double>(json['avgKmPerDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'plateNumber': serializer.toJson<String>(plateNumber),
      'make': serializer.toJson<String?>(make),
      'model': serializer.toJson<String?>(model),
      'fuelPassQr': serializer.toJson<String?>(fuelPassQr),
      'weeklyQuotaL': serializer.toJson<double>(weeklyQuotaL),
      'remainingQuotaL': serializer.toJson<double>(remainingQuotaL),
      'quotaResetAt': serializer.toJson<int?>(quotaResetAt),
      'isActive': serializer.toJson<bool>(isActive),
      'currentOdometerKm': serializer.toJson<int>(currentOdometerKm),
      'avgKmPerDay': serializer.toJson<double>(avgKmPerDay),
    };
  }

  Vehicle copyWith({
    int? id,
    String? plateNumber,
    Value<String?> make = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> fuelPassQr = const Value.absent(),
    double? weeklyQuotaL,
    double? remainingQuotaL,
    Value<int?> quotaResetAt = const Value.absent(),
    bool? isActive,
    int? currentOdometerKm,
    double? avgKmPerDay,
  }) => Vehicle(
    id: id ?? this.id,
    plateNumber: plateNumber ?? this.plateNumber,
    make: make.present ? make.value : this.make,
    model: model.present ? model.value : this.model,
    fuelPassQr: fuelPassQr.present ? fuelPassQr.value : this.fuelPassQr,
    weeklyQuotaL: weeklyQuotaL ?? this.weeklyQuotaL,
    remainingQuotaL: remainingQuotaL ?? this.remainingQuotaL,
    quotaResetAt: quotaResetAt.present ? quotaResetAt.value : this.quotaResetAt,
    isActive: isActive ?? this.isActive,
    currentOdometerKm: currentOdometerKm ?? this.currentOdometerKm,
    avgKmPerDay: avgKmPerDay ?? this.avgKmPerDay,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      plateNumber: data.plateNumber.present
          ? data.plateNumber.value
          : this.plateNumber,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      fuelPassQr: data.fuelPassQr.present
          ? data.fuelPassQr.value
          : this.fuelPassQr,
      weeklyQuotaL: data.weeklyQuotaL.present
          ? data.weeklyQuotaL.value
          : this.weeklyQuotaL,
      remainingQuotaL: data.remainingQuotaL.present
          ? data.remainingQuotaL.value
          : this.remainingQuotaL,
      quotaResetAt: data.quotaResetAt.present
          ? data.quotaResetAt.value
          : this.quotaResetAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      currentOdometerKm: data.currentOdometerKm.present
          ? data.currentOdometerKm.value
          : this.currentOdometerKm,
      avgKmPerDay: data.avgKmPerDay.present
          ? data.avgKmPerDay.value
          : this.avgKmPerDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('fuelPassQr: $fuelPassQr, ')
          ..write('weeklyQuotaL: $weeklyQuotaL, ')
          ..write('remainingQuotaL: $remainingQuotaL, ')
          ..write('quotaResetAt: $quotaResetAt, ')
          ..write('isActive: $isActive, ')
          ..write('currentOdometerKm: $currentOdometerKm, ')
          ..write('avgKmPerDay: $avgKmPerDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    plateNumber,
    make,
    model,
    fuelPassQr,
    weeklyQuotaL,
    remainingQuotaL,
    quotaResetAt,
    isActive,
    currentOdometerKm,
    avgKmPerDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.plateNumber == this.plateNumber &&
          other.make == this.make &&
          other.model == this.model &&
          other.fuelPassQr == this.fuelPassQr &&
          other.weeklyQuotaL == this.weeklyQuotaL &&
          other.remainingQuotaL == this.remainingQuotaL &&
          other.quotaResetAt == this.quotaResetAt &&
          other.isActive == this.isActive &&
          other.currentOdometerKm == this.currentOdometerKm &&
          other.avgKmPerDay == this.avgKmPerDay);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<int> id;
  final Value<String> plateNumber;
  final Value<String?> make;
  final Value<String?> model;
  final Value<String?> fuelPassQr;
  final Value<double> weeklyQuotaL;
  final Value<double> remainingQuotaL;
  final Value<int?> quotaResetAt;
  final Value<bool> isActive;
  final Value<int> currentOdometerKm;
  final Value<double> avgKmPerDay;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.plateNumber = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.fuelPassQr = const Value.absent(),
    this.weeklyQuotaL = const Value.absent(),
    this.remainingQuotaL = const Value.absent(),
    this.quotaResetAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.currentOdometerKm = const Value.absent(),
    this.avgKmPerDay = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.id = const Value.absent(),
    required String plateNumber,
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.fuelPassQr = const Value.absent(),
    this.weeklyQuotaL = const Value.absent(),
    this.remainingQuotaL = const Value.absent(),
    this.quotaResetAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.currentOdometerKm = const Value.absent(),
    this.avgKmPerDay = const Value.absent(),
  }) : plateNumber = Value(plateNumber);
  static Insertable<Vehicle> custom({
    Expression<int>? id,
    Expression<String>? plateNumber,
    Expression<String>? make,
    Expression<String>? model,
    Expression<String>? fuelPassQr,
    Expression<double>? weeklyQuotaL,
    Expression<double>? remainingQuotaL,
    Expression<int>? quotaResetAt,
    Expression<bool>? isActive,
    Expression<int>? currentOdometerKm,
    Expression<double>? avgKmPerDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plateNumber != null) 'plate_number': plateNumber,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (fuelPassQr != null) 'fuel_pass_qr': fuelPassQr,
      if (weeklyQuotaL != null) 'weekly_quota_l': weeklyQuotaL,
      if (remainingQuotaL != null) 'remaining_quota_l': remainingQuotaL,
      if (quotaResetAt != null) 'quota_reset_at': quotaResetAt,
      if (isActive != null) 'is_active': isActive,
      if (currentOdometerKm != null) 'current_odometer_km': currentOdometerKm,
      if (avgKmPerDay != null) 'avg_km_per_day': avgKmPerDay,
    });
  }

  VehiclesCompanion copyWith({
    Value<int>? id,
    Value<String>? plateNumber,
    Value<String?>? make,
    Value<String?>? model,
    Value<String?>? fuelPassQr,
    Value<double>? weeklyQuotaL,
    Value<double>? remainingQuotaL,
    Value<int?>? quotaResetAt,
    Value<bool>? isActive,
    Value<int>? currentOdometerKm,
    Value<double>? avgKmPerDay,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      plateNumber: plateNumber ?? this.plateNumber,
      make: make ?? this.make,
      model: model ?? this.model,
      fuelPassQr: fuelPassQr ?? this.fuelPassQr,
      weeklyQuotaL: weeklyQuotaL ?? this.weeklyQuotaL,
      remainingQuotaL: remainingQuotaL ?? this.remainingQuotaL,
      quotaResetAt: quotaResetAt ?? this.quotaResetAt,
      isActive: isActive ?? this.isActive,
      currentOdometerKm: currentOdometerKm ?? this.currentOdometerKm,
      avgKmPerDay: avgKmPerDay ?? this.avgKmPerDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (plateNumber.present) {
      map['plate_number'] = Variable<String>(plateNumber.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (fuelPassQr.present) {
      map['fuel_pass_qr'] = Variable<String>(fuelPassQr.value);
    }
    if (weeklyQuotaL.present) {
      map['weekly_quota_l'] = Variable<double>(weeklyQuotaL.value);
    }
    if (remainingQuotaL.present) {
      map['remaining_quota_l'] = Variable<double>(remainingQuotaL.value);
    }
    if (quotaResetAt.present) {
      map['quota_reset_at'] = Variable<int>(quotaResetAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (currentOdometerKm.present) {
      map['current_odometer_km'] = Variable<int>(currentOdometerKm.value);
    }
    if (avgKmPerDay.present) {
      map['avg_km_per_day'] = Variable<double>(avgKmPerDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('fuelPassQr: $fuelPassQr, ')
          ..write('weeklyQuotaL: $weeklyQuotaL, ')
          ..write('remainingQuotaL: $remainingQuotaL, ')
          ..write('quotaResetAt: $quotaResetAt, ')
          ..write('isActive: $isActive, ')
          ..write('currentOdometerKm: $currentOdometerKm, ')
          ..write('avgKmPerDay: $avgKmPerDay')
          ..write(')'))
        .toString();
  }
}

class $ComplianceLogsTable extends ComplianceLogs
    with TableInfo<$ComplianceLogsTable, ComplianceLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComplianceLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<int> issuedAt = GeneratedColumn<int>(
    'issued_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<int> expiresAt = GeneratedColumn<int>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _documentPathMeta = const VerificationMeta(
    'documentPath',
  );
  @override
  late final GeneratedColumn<String> documentPath = GeneratedColumn<String>(
    'document_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    type,
    issuedAt,
    expiresAt,
    cost,
    documentPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'compliance_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComplianceLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('document_path')) {
      context.handle(
        _documentPathMeta,
        documentPath.isAcceptableOrUnknown(
          data['document_path']!,
          _documentPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComplianceLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComplianceLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}issued_at'],
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expires_at'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
      documentPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_path'],
      ),
    );
  }

  @override
  $ComplianceLogsTable createAlias(String alias) {
    return $ComplianceLogsTable(attachedDatabase, alias);
  }
}

class ComplianceLog extends DataClass implements Insertable<ComplianceLog> {
  final int id;
  final int vehicleId;
  final String type;
  final int? issuedAt;
  final int expiresAt;
  final double? cost;
  final String? documentPath;
  const ComplianceLog({
    required this.id,
    required this.vehicleId,
    required this.type,
    this.issuedAt,
    required this.expiresAt,
    this.cost,
    this.documentPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || issuedAt != null) {
      map['issued_at'] = Variable<int>(issuedAt);
    }
    map['expires_at'] = Variable<int>(expiresAt);
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    if (!nullToAbsent || documentPath != null) {
      map['document_path'] = Variable<String>(documentPath);
    }
    return map;
  }

  ComplianceLogsCompanion toCompanion(bool nullToAbsent) {
    return ComplianceLogsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      type: Value(type),
      issuedAt: issuedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(issuedAt),
      expiresAt: Value(expiresAt),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      documentPath: documentPath == null && nullToAbsent
          ? const Value.absent()
          : Value(documentPath),
    );
  }

  factory ComplianceLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComplianceLog(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      type: serializer.fromJson<String>(json['type']),
      issuedAt: serializer.fromJson<int?>(json['issuedAt']),
      expiresAt: serializer.fromJson<int>(json['expiresAt']),
      cost: serializer.fromJson<double?>(json['cost']),
      documentPath: serializer.fromJson<String?>(json['documentPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'type': serializer.toJson<String>(type),
      'issuedAt': serializer.toJson<int?>(issuedAt),
      'expiresAt': serializer.toJson<int>(expiresAt),
      'cost': serializer.toJson<double?>(cost),
      'documentPath': serializer.toJson<String?>(documentPath),
    };
  }

  ComplianceLog copyWith({
    int? id,
    int? vehicleId,
    String? type,
    Value<int?> issuedAt = const Value.absent(),
    int? expiresAt,
    Value<double?> cost = const Value.absent(),
    Value<String?> documentPath = const Value.absent(),
  }) => ComplianceLog(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    type: type ?? this.type,
    issuedAt: issuedAt.present ? issuedAt.value : this.issuedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    cost: cost.present ? cost.value : this.cost,
    documentPath: documentPath.present ? documentPath.value : this.documentPath,
  );
  ComplianceLog copyWithCompanion(ComplianceLogsCompanion data) {
    return ComplianceLog(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      type: data.type.present ? data.type.value : this.type,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      cost: data.cost.present ? data.cost.value : this.cost,
      documentPath: data.documentPath.present
          ? data.documentPath.value
          : this.documentPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComplianceLog(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('cost: $cost, ')
          ..write('documentPath: $documentPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, vehicleId, type, issuedAt, expiresAt, cost, documentPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComplianceLog &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.type == this.type &&
          other.issuedAt == this.issuedAt &&
          other.expiresAt == this.expiresAt &&
          other.cost == this.cost &&
          other.documentPath == this.documentPath);
}

class ComplianceLogsCompanion extends UpdateCompanion<ComplianceLog> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> type;
  final Value<int?> issuedAt;
  final Value<int> expiresAt;
  final Value<double?> cost;
  final Value<String?> documentPath;
  const ComplianceLogsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.type = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.cost = const Value.absent(),
    this.documentPath = const Value.absent(),
  });
  ComplianceLogsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String type,
    this.issuedAt = const Value.absent(),
    required int expiresAt,
    this.cost = const Value.absent(),
    this.documentPath = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       type = Value(type),
       expiresAt = Value(expiresAt);
  static Insertable<ComplianceLog> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? type,
    Expression<int>? issuedAt,
    Expression<int>? expiresAt,
    Expression<double>? cost,
    Expression<String>? documentPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (type != null) 'type': type,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (cost != null) 'cost': cost,
      if (documentPath != null) 'document_path': documentPath,
    });
  }

  ComplianceLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? type,
    Value<int?>? issuedAt,
    Value<int>? expiresAt,
    Value<double?>? cost,
    Value<String?>? documentPath,
  }) {
    return ComplianceLogsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      cost: cost ?? this.cost,
      documentPath: documentPath ?? this.documentPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<int>(issuedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (documentPath.present) {
      map['document_path'] = Variable<String>(documentPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComplianceLogsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('type: $type, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('cost: $cost, ')
          ..write('documentPath: $documentPath')
          ..write(')'))
        .toString();
  }
}

class $ServiceLogsTable extends ServiceLogs
    with TableInfo<$ServiceLogsTable, ServiceLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _serviceDateMeta = const VerificationMeta(
    'serviceDate',
  );
  @override
  late final GeneratedColumn<int> serviceDate = GeneratedColumn<int>(
    'service_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueKmMeta = const VerificationMeta(
    'nextDueKm',
  );
  @override
  late final GeneratedColumn<int> nextDueKm = GeneratedColumn<int>(
    'next_due_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<int> nextDueDate = GeneratedColumn<int>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    description,
    serviceDate,
    odometer,
    cost,
    nextDueKm,
    nextDueDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
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
    if (data.containsKey('service_date')) {
      context.handle(
        _serviceDateMeta,
        serviceDate.isAcceptableOrUnknown(
          data['service_date']!,
          _serviceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceDateMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('next_due_km')) {
      context.handle(
        _nextDueKmMeta,
        nextDueKm.isAcceptableOrUnknown(data['next_due_km']!, _nextDueKmMeta),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      serviceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}service_date'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      ),
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
      nextDueKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_due_km'],
      ),
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_due_date'],
      ),
    );
  }

  @override
  $ServiceLogsTable createAlias(String alias) {
    return $ServiceLogsTable(attachedDatabase, alias);
  }
}

class ServiceLog extends DataClass implements Insertable<ServiceLog> {
  final int id;
  final int vehicleId;
  final String description;
  final int serviceDate;
  final int? odometer;
  final double? cost;
  final int? nextDueKm;
  final int? nextDueDate;
  const ServiceLog({
    required this.id,
    required this.vehicleId,
    required this.description,
    required this.serviceDate,
    this.odometer,
    this.cost,
    this.nextDueKm,
    this.nextDueDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['description'] = Variable<String>(description);
    map['service_date'] = Variable<int>(serviceDate);
    if (!nullToAbsent || odometer != null) {
      map['odometer'] = Variable<int>(odometer);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    if (!nullToAbsent || nextDueKm != null) {
      map['next_due_km'] = Variable<int>(nextDueKm);
    }
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<int>(nextDueDate);
    }
    return map;
  }

  ServiceLogsCompanion toCompanion(bool nullToAbsent) {
    return ServiceLogsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      description: Value(description),
      serviceDate: Value(serviceDate),
      odometer: odometer == null && nullToAbsent
          ? const Value.absent()
          : Value(odometer),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      nextDueKm: nextDueKm == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueKm),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
    );
  }

  factory ServiceLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceLog(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      description: serializer.fromJson<String>(json['description']),
      serviceDate: serializer.fromJson<int>(json['serviceDate']),
      odometer: serializer.fromJson<int?>(json['odometer']),
      cost: serializer.fromJson<double?>(json['cost']),
      nextDueKm: serializer.fromJson<int?>(json['nextDueKm']),
      nextDueDate: serializer.fromJson<int?>(json['nextDueDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'description': serializer.toJson<String>(description),
      'serviceDate': serializer.toJson<int>(serviceDate),
      'odometer': serializer.toJson<int?>(odometer),
      'cost': serializer.toJson<double?>(cost),
      'nextDueKm': serializer.toJson<int?>(nextDueKm),
      'nextDueDate': serializer.toJson<int?>(nextDueDate),
    };
  }

  ServiceLog copyWith({
    int? id,
    int? vehicleId,
    String? description,
    int? serviceDate,
    Value<int?> odometer = const Value.absent(),
    Value<double?> cost = const Value.absent(),
    Value<int?> nextDueKm = const Value.absent(),
    Value<int?> nextDueDate = const Value.absent(),
  }) => ServiceLog(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    description: description ?? this.description,
    serviceDate: serviceDate ?? this.serviceDate,
    odometer: odometer.present ? odometer.value : this.odometer,
    cost: cost.present ? cost.value : this.cost,
    nextDueKm: nextDueKm.present ? nextDueKm.value : this.nextDueKm,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
  );
  ServiceLog copyWithCompanion(ServiceLogsCompanion data) {
    return ServiceLog(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      description: data.description.present
          ? data.description.value
          : this.description,
      serviceDate: data.serviceDate.present
          ? data.serviceDate.value
          : this.serviceDate,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      cost: data.cost.present ? data.cost.value : this.cost,
      nextDueKm: data.nextDueKm.present ? data.nextDueKm.value : this.nextDueKm,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceLog(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('description: $description, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometer: $odometer, ')
          ..write('cost: $cost, ')
          ..write('nextDueKm: $nextDueKm, ')
          ..write('nextDueDate: $nextDueDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    description,
    serviceDate,
    odometer,
    cost,
    nextDueKm,
    nextDueDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceLog &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.description == this.description &&
          other.serviceDate == this.serviceDate &&
          other.odometer == this.odometer &&
          other.cost == this.cost &&
          other.nextDueKm == this.nextDueKm &&
          other.nextDueDate == this.nextDueDate);
}

class ServiceLogsCompanion extends UpdateCompanion<ServiceLog> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<String> description;
  final Value<int> serviceDate;
  final Value<int?> odometer;
  final Value<double?> cost;
  final Value<int?> nextDueKm;
  final Value<int?> nextDueDate;
  const ServiceLogsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.description = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.odometer = const Value.absent(),
    this.cost = const Value.absent(),
    this.nextDueKm = const Value.absent(),
    this.nextDueDate = const Value.absent(),
  });
  ServiceLogsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required String description,
    required int serviceDate,
    this.odometer = const Value.absent(),
    this.cost = const Value.absent(),
    this.nextDueKm = const Value.absent(),
    this.nextDueDate = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       description = Value(description),
       serviceDate = Value(serviceDate);
  static Insertable<ServiceLog> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<String>? description,
    Expression<int>? serviceDate,
    Expression<int>? odometer,
    Expression<double>? cost,
    Expression<int>? nextDueKm,
    Expression<int>? nextDueDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (description != null) 'description': description,
      if (serviceDate != null) 'service_date': serviceDate,
      if (odometer != null) 'odometer': odometer,
      if (cost != null) 'cost': cost,
      if (nextDueKm != null) 'next_due_km': nextDueKm,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
    });
  }

  ServiceLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<String>? description,
    Value<int>? serviceDate,
    Value<int?>? odometer,
    Value<double?>? cost,
    Value<int?>? nextDueKm,
    Value<int?>? nextDueDate,
  }) {
    return ServiceLogsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      description: description ?? this.description,
      serviceDate: serviceDate ?? this.serviceDate,
      odometer: odometer ?? this.odometer,
      cost: cost ?? this.cost,
      nextDueKm: nextDueKm ?? this.nextDueKm,
      nextDueDate: nextDueDate ?? this.nextDueDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<int>(serviceDate.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (nextDueKm.present) {
      map['next_due_km'] = Variable<int>(nextDueKm.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<int>(nextDueDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceLogsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('description: $description, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometer: $odometer, ')
          ..write('cost: $cost, ')
          ..write('nextDueKm: $nextDueKm, ')
          ..write('nextDueDate: $nextDueDate')
          ..write(')'))
        .toString();
  }
}

class $FuelTransactionsTable extends FuelTransactions
    with TableInfo<$FuelTransactionsTable, FuelTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelTransactionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<int> transactionDate = GeneratedColumn<int>(
    'transaction_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litresMeta = const VerificationMeta('litres');
  @override
  late final GeneratedColumn<double> litres = GeneratedColumn<double>(
    'litres',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceLMeta = const VerificationMeta(
    'balanceL',
  );
  @override
  late final GeneratedColumn<double> balanceL = GeneratedColumn<double>(
    'balance_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<int> odometerKm = GeneratedColumn<int>(
    'odometer_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    transactionDate,
    litres,
    cost,
    balanceL,
    odometerKm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('litres')) {
      context.handle(
        _litresMeta,
        litres.isAcceptableOrUnknown(data['litres']!, _litresMeta),
      );
    } else if (isInserting) {
      context.missing(_litresMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('balance_l')) {
      context.handle(
        _balanceLMeta,
        balanceL.isAcceptableOrUnknown(data['balance_l']!, _balanceLMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceLMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_id'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_date'],
      )!,
      litres: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}litres'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      balanceL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance_l'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer_km'],
      ),
    );
  }

  @override
  $FuelTransactionsTable createAlias(String alias) {
    return $FuelTransactionsTable(attachedDatabase, alias);
  }
}

class FuelTransaction extends DataClass implements Insertable<FuelTransaction> {
  final int id;
  final int vehicleId;
  final int transactionDate;
  final double litres;
  final double cost;
  final double balanceL;
  final int? odometerKm;
  const FuelTransaction({
    required this.id,
    required this.vehicleId,
    required this.transactionDate,
    required this.litres,
    required this.cost,
    required this.balanceL,
    this.odometerKm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['transaction_date'] = Variable<int>(transactionDate);
    map['litres'] = Variable<double>(litres);
    map['cost'] = Variable<double>(cost);
    map['balance_l'] = Variable<double>(balanceL);
    if (!nullToAbsent || odometerKm != null) {
      map['odometer_km'] = Variable<int>(odometerKm);
    }
    return map;
  }

  FuelTransactionsCompanion toCompanion(bool nullToAbsent) {
    return FuelTransactionsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      transactionDate: Value(transactionDate),
      litres: Value(litres),
      cost: Value(cost),
      balanceL: Value(balanceL),
      odometerKm: odometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(odometerKm),
    );
  }

  factory FuelTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelTransaction(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      transactionDate: serializer.fromJson<int>(json['transactionDate']),
      litres: serializer.fromJson<double>(json['litres']),
      cost: serializer.fromJson<double>(json['cost']),
      balanceL: serializer.fromJson<double>(json['balanceL']),
      odometerKm: serializer.fromJson<int?>(json['odometerKm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'transactionDate': serializer.toJson<int>(transactionDate),
      'litres': serializer.toJson<double>(litres),
      'cost': serializer.toJson<double>(cost),
      'balanceL': serializer.toJson<double>(balanceL),
      'odometerKm': serializer.toJson<int?>(odometerKm),
    };
  }

  FuelTransaction copyWith({
    int? id,
    int? vehicleId,
    int? transactionDate,
    double? litres,
    double? cost,
    double? balanceL,
    Value<int?> odometerKm = const Value.absent(),
  }) => FuelTransaction(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    transactionDate: transactionDate ?? this.transactionDate,
    litres: litres ?? this.litres,
    cost: cost ?? this.cost,
    balanceL: balanceL ?? this.balanceL,
    odometerKm: odometerKm.present ? odometerKm.value : this.odometerKm,
  );
  FuelTransaction copyWithCompanion(FuelTransactionsCompanion data) {
    return FuelTransaction(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      litres: data.litres.present ? data.litres.value : this.litres,
      cost: data.cost.present ? data.cost.value : this.cost,
      balanceL: data.balanceL.present ? data.balanceL.value : this.balanceL,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelTransaction(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('litres: $litres, ')
          ..write('cost: $cost, ')
          ..write('balanceL: $balanceL, ')
          ..write('odometerKm: $odometerKm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    transactionDate,
    litres,
    cost,
    balanceL,
    odometerKm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelTransaction &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.transactionDate == this.transactionDate &&
          other.litres == this.litres &&
          other.cost == this.cost &&
          other.balanceL == this.balanceL &&
          other.odometerKm == this.odometerKm);
}

class FuelTransactionsCompanion extends UpdateCompanion<FuelTransaction> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<int> transactionDate;
  final Value<double> litres;
  final Value<double> cost;
  final Value<double> balanceL;
  final Value<int?> odometerKm;
  const FuelTransactionsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.litres = const Value.absent(),
    this.cost = const Value.absent(),
    this.balanceL = const Value.absent(),
    this.odometerKm = const Value.absent(),
  });
  FuelTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required int transactionDate,
    required double litres,
    required double cost,
    required double balanceL,
    this.odometerKm = const Value.absent(),
  }) : vehicleId = Value(vehicleId),
       transactionDate = Value(transactionDate),
       litres = Value(litres),
       cost = Value(cost),
       balanceL = Value(balanceL);
  static Insertable<FuelTransaction> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<int>? transactionDate,
    Expression<double>? litres,
    Expression<double>? cost,
    Expression<double>? balanceL,
    Expression<int>? odometerKm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (litres != null) 'litres': litres,
      if (cost != null) 'cost': cost,
      if (balanceL != null) 'balance_l': balanceL,
      if (odometerKm != null) 'odometer_km': odometerKm,
    });
  }

  FuelTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? vehicleId,
    Value<int>? transactionDate,
    Value<double>? litres,
    Value<double>? cost,
    Value<double>? balanceL,
    Value<int?>? odometerKm,
  }) {
    return FuelTransactionsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      transactionDate: transactionDate ?? this.transactionDate,
      litres: litres ?? this.litres,
      cost: cost ?? this.cost,
      balanceL: balanceL ?? this.balanceL,
      odometerKm: odometerKm ?? this.odometerKm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<int>(transactionDate.value);
    }
    if (litres.present) {
      map['litres'] = Variable<double>(litres.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (balanceL.present) {
      map['balance_l'] = Variable<double>(balanceL.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<int>(odometerKm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('litres: $litres, ')
          ..write('cost: $cost, ')
          ..write('balanceL: $balanceL, ')
          ..write('odometerKm: $odometerKm')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $ComplianceLogsTable complianceLogs = $ComplianceLogsTable(this);
  late final $ServiceLogsTable serviceLogs = $ServiceLogsTable(this);
  late final $FuelTransactionsTable fuelTransactions = $FuelTransactionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vehicles,
    complianceLogs,
    serviceLogs,
    fuelTransactions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('compliance_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('service_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fuel_transactions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  Value<int> id,
  required String plateNumber,
  Value<String?> make,
  Value<String?> model,
  Value<String?> fuelPassQr,
  Value<double> weeklyQuotaL,
  Value<double> remainingQuotaL,
  Value<int?> quotaResetAt,
  Value<bool> isActive,
  Value<int> currentOdometerKm,
  Value<double> avgKmPerDay,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<int> id,
  Value<String> plateNumber,
  Value<String?> make,
  Value<String?> model,
  Value<String?> fuelPassQr,
  Value<double> weeklyQuotaL,
  Value<double> remainingQuotaL,
  Value<int?> quotaResetAt,
  Value<bool> isActive,
  Value<int> currentOdometerKm,
  Value<double> avgKmPerDay,
});

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ComplianceLogsTable, List<ComplianceLog>>
  _complianceLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.complianceLogs,
    aliasName: 'vehicles__id__compliance_logs__vehicle_id',
  );

  $$ComplianceLogsTableProcessedTableManager get complianceLogsRefs {
    final manager = $$ComplianceLogsTableTableManager(
      $_db,
      $_db.complianceLogs,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_complianceLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ServiceLogsTable, List<ServiceLog>>
  _serviceLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceLogs,
    aliasName: 'vehicles__id__service_logs__vehicle_id',
  );

  $$ServiceLogsTableProcessedTableManager get serviceLogsRefs {
    final manager = $$ServiceLogsTableTableManager(
      $_db,
      $_db.serviceLogs,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FuelTransactionsTable, List<FuelTransaction>>
  _fuelTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelTransactions,
    aliasName: 'vehicles__id__fuel_transactions__vehicle_id',
  );

  $$FuelTransactionsTableProcessedTableManager get fuelTransactionsRefs {
    final manager = $$FuelTransactionsTableTableManager(
      $_db,
      $_db.fuelTransactions,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fuelTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
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

  ColumnFilters<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelPassQr => $composableBuilder(
    column: $table.fuelPassQr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weeklyQuotaL => $composableBuilder(
    column: $table.weeklyQuotaL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingQuotaL => $composableBuilder(
    column: $table.remainingQuotaL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quotaResetAt => $composableBuilder(
    column: $table.quotaResetAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentOdometerKm => $composableBuilder(
    column: $table.currentOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgKmPerDay => $composableBuilder(
    column: $table.avgKmPerDay,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> complianceLogsRefs(
    Expression<bool> Function($$ComplianceLogsTableFilterComposer f) f,
  ) {
    final $$ComplianceLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.complianceLogs,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComplianceLogsTableFilterComposer(
            $db: $db,
            $table: $db.complianceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> serviceLogsRefs(
    Expression<bool> Function($$ServiceLogsTableFilterComposer f) f,
  ) {
    final $$ServiceLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceLogs,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceLogsTableFilterComposer(
            $db: $db,
            $table: $db.serviceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fuelTransactionsRefs(
    Expression<bool> Function($$FuelTransactionsTableFilterComposer f) f,
  ) {
    final $$FuelTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelTransactions,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.fuelTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
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

  ColumnOrderings<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelPassQr => $composableBuilder(
    column: $table.fuelPassQr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weeklyQuotaL => $composableBuilder(
    column: $table.weeklyQuotaL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingQuotaL => $composableBuilder(
    column: $table.remainingQuotaL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quotaResetAt => $composableBuilder(
    column: $table.quotaResetAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentOdometerKm => $composableBuilder(
    column: $table.currentOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgKmPerDay => $composableBuilder(
    column: $table.avgKmPerDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get fuelPassQr => $composableBuilder(
    column: $table.fuelPassQr,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weeklyQuotaL => $composableBuilder(
    column: $table.weeklyQuotaL,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingQuotaL => $composableBuilder(
    column: $table.remainingQuotaL,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quotaResetAt => $composableBuilder(
    column: $table.quotaResetAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get currentOdometerKm => $composableBuilder(
    column: $table.currentOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgKmPerDay => $composableBuilder(
    column: $table.avgKmPerDay,
    builder: (column) => column,
  );

  Expression<T> complianceLogsRefs<T extends Object>(
    Expression<T> Function($$ComplianceLogsTableAnnotationComposer a) f,
  ) {
    final $$ComplianceLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.complianceLogs,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComplianceLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.complianceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> serviceLogsRefs<T extends Object>(
    Expression<T> Function($$ServiceLogsTableAnnotationComposer a) f,
  ) {
    final $$ServiceLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceLogs,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fuelTransactionsRefs<T extends Object>(
    Expression<T> Function($$FuelTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FuelTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelTransactions,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, $$VehiclesTableReferences),
          Vehicle,
          PrefetchHooks Function({
            bool complianceLogsRefs,
            bool serviceLogsRefs,
            bool fuelTransactionsRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> plateNumber = const Value.absent(),
                Value<String?> make = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> fuelPassQr = const Value.absent(),
                Value<double> weeklyQuotaL = const Value.absent(),
                Value<double> remainingQuotaL = const Value.absent(),
                Value<int?> quotaResetAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> currentOdometerKm = const Value.absent(),
                Value<double> avgKmPerDay = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                plateNumber: plateNumber,
                make: make,
                model: model,
                fuelPassQr: fuelPassQr,
                weeklyQuotaL: weeklyQuotaL,
                remainingQuotaL: remainingQuotaL,
                quotaResetAt: quotaResetAt,
                isActive: isActive,
                currentOdometerKm: currentOdometerKm,
                avgKmPerDay: avgKmPerDay,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String plateNumber,
                Value<String?> make = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> fuelPassQr = const Value.absent(),
                Value<double> weeklyQuotaL = const Value.absent(),
                Value<double> remainingQuotaL = const Value.absent(),
                Value<int?> quotaResetAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> currentOdometerKm = const Value.absent(),
                Value<double> avgKmPerDay = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                plateNumber: plateNumber,
                make: make,
                model: model,
                fuelPassQr: fuelPassQr,
                weeklyQuotaL: weeklyQuotaL,
                remainingQuotaL: remainingQuotaL,
                quotaResetAt: quotaResetAt,
                isActive: isActive,
                currentOdometerKm: currentOdometerKm,
                avgKmPerDay: avgKmPerDay,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiclesTable, Vehicle>(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                complianceLogsRefs = false,
                serviceLogsRefs = false,
                fuelTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (complianceLogsRefs) db.complianceLogs,
                    if (serviceLogsRefs) db.serviceLogs,
                    if (fuelTransactionsRefs) db.fuelTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (complianceLogsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          ComplianceLog
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._complianceLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).complianceLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (serviceLogsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          ServiceLog
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._serviceLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).serviceLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fuelTransactionsRefs)
                        await $_getPrefetchedData<
                          Vehicle,
                          $VehiclesTable,
                          FuelTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, $$VehiclesTableReferences),
      Vehicle,
      PrefetchHooks Function({
        bool complianceLogsRefs,
        bool serviceLogsRefs,
        bool fuelTransactionsRefs,
      })
    >;
typedef $$ComplianceLogsTableCreateCompanionBuilder =
    ComplianceLogsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String type,
      Value<int?> issuedAt,
      required int expiresAt,
      Value<double?> cost,
      Value<String?> documentPath,
    });
typedef $$ComplianceLogsTableUpdateCompanionBuilder =
    ComplianceLogsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> type,
      Value<int?> issuedAt,
      Value<int> expiresAt,
      Value<double?> cost,
      Value<String?> documentPath,
    });

final class $$ComplianceLogsTableReferences
    extends BaseReferences<_$AppDatabase, $ComplianceLogsTable, ComplianceLog> {
  $$ComplianceLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('compliance_logs__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ComplianceLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ComplianceLogsTable> {
  $$ComplianceLogsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentPath => $composableBuilder(
    column: $table.documentPath,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplianceLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ComplianceLogsTable> {
  $$ComplianceLogsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentPath => $composableBuilder(
    column: $table.documentPath,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplianceLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComplianceLogsTable> {
  $$ComplianceLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<int> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get documentPath => $composableBuilder(
    column: $table.documentPath,
    builder: (column) => column,
  );

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComplianceLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComplianceLogsTable,
          ComplianceLog,
          $$ComplianceLogsTableFilterComposer,
          $$ComplianceLogsTableOrderingComposer,
          $$ComplianceLogsTableAnnotationComposer,
          $$ComplianceLogsTableCreateCompanionBuilder,
          $$ComplianceLogsTableUpdateCompanionBuilder,
          (ComplianceLog, $$ComplianceLogsTableReferences),
          ComplianceLog,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$ComplianceLogsTableTableManager(
    _$AppDatabase db,
    $ComplianceLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComplianceLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComplianceLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComplianceLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> issuedAt = const Value.absent(),
                Value<int> expiresAt = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<String?> documentPath = const Value.absent(),
              }) => ComplianceLogsCompanion(
                id: id,
                vehicleId: vehicleId,
                type: type,
                issuedAt: issuedAt,
                expiresAt: expiresAt,
                cost: cost,
                documentPath: documentPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String type,
                Value<int?> issuedAt = const Value.absent(),
                required int expiresAt,
                Value<double?> cost = const Value.absent(),
                Value<String?> documentPath = const Value.absent(),
              }) => ComplianceLogsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                type: type,
                issuedAt: issuedAt,
                expiresAt: expiresAt,
                cost: cost,
                documentPath: documentPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ComplianceLogsTable, ComplianceLog>(table),
                  $$ComplianceLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
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
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$ComplianceLogsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$ComplianceLogsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
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

typedef $$ComplianceLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComplianceLogsTable,
      ComplianceLog,
      $$ComplianceLogsTableFilterComposer,
      $$ComplianceLogsTableOrderingComposer,
      $$ComplianceLogsTableAnnotationComposer,
      $$ComplianceLogsTableCreateCompanionBuilder,
      $$ComplianceLogsTableUpdateCompanionBuilder,
      (ComplianceLog, $$ComplianceLogsTableReferences),
      ComplianceLog,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$ServiceLogsTableCreateCompanionBuilder =
    ServiceLogsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required String description,
      required int serviceDate,
      Value<int?> odometer,
      Value<double?> cost,
      Value<int?> nextDueKm,
      Value<int?> nextDueDate,
    });
typedef $$ServiceLogsTableUpdateCompanionBuilder =
    ServiceLogsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<String> description,
      Value<int> serviceDate,
      Value<int?> odometer,
      Value<double?> cost,
      Value<int?> nextDueKm,
      Value<int?> nextDueDate,
    });

final class $$ServiceLogsTableReferences
    extends BaseReferences<_$AppDatabase, $ServiceLogsTable, ServiceLog> {
  $$ServiceLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('service_logs__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ServiceLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceLogsTable> {
  $$ServiceLogsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextDueKm => $composableBuilder(
    column: $table.nextDueKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceLogsTable> {
  $$ServiceLogsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextDueKm => $composableBuilder(
    column: $table.nextDueKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceLogsTable> {
  $$ServiceLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<int> get nextDueKm =>
      $composableBuilder(column: $table.nextDueKm, builder: (column) => column);

  GeneratedColumn<int> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceLogsTable,
          ServiceLog,
          $$ServiceLogsTableFilterComposer,
          $$ServiceLogsTableOrderingComposer,
          $$ServiceLogsTableAnnotationComposer,
          $$ServiceLogsTableCreateCompanionBuilder,
          $$ServiceLogsTableUpdateCompanionBuilder,
          (ServiceLog, $$ServiceLogsTableReferences),
          ServiceLog,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$ServiceLogsTableTableManager(_$AppDatabase db, $ServiceLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> serviceDate = const Value.absent(),
                Value<int?> odometer = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<int?> nextDueKm = const Value.absent(),
                Value<int?> nextDueDate = const Value.absent(),
              }) => ServiceLogsCompanion(
                id: id,
                vehicleId: vehicleId,
                description: description,
                serviceDate: serviceDate,
                odometer: odometer,
                cost: cost,
                nextDueKm: nextDueKm,
                nextDueDate: nextDueDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required String description,
                required int serviceDate,
                Value<int?> odometer = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<int?> nextDueKm = const Value.absent(),
                Value<int?> nextDueDate = const Value.absent(),
              }) => ServiceLogsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                description: description,
                serviceDate: serviceDate,
                odometer: odometer,
                cost: cost,
                nextDueKm: nextDueKm,
                nextDueDate: nextDueDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ServiceLogsTable, ServiceLog>(table),
                  $$ServiceLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
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
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$ServiceLogsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$ServiceLogsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
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

typedef $$ServiceLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceLogsTable,
      ServiceLog,
      $$ServiceLogsTableFilterComposer,
      $$ServiceLogsTableOrderingComposer,
      $$ServiceLogsTableAnnotationComposer,
      $$ServiceLogsTableCreateCompanionBuilder,
      $$ServiceLogsTableUpdateCompanionBuilder,
      (ServiceLog, $$ServiceLogsTableReferences),
      ServiceLog,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$FuelTransactionsTableCreateCompanionBuilder =
    FuelTransactionsCompanion Function({
      Value<int> id,
      required int vehicleId,
      required int transactionDate,
      required double litres,
      required double cost,
      required double balanceL,
      Value<int?> odometerKm,
    });
typedef $$FuelTransactionsTableUpdateCompanionBuilder =
    FuelTransactionsCompanion Function({
      Value<int> id,
      Value<int> vehicleId,
      Value<int> transactionDate,
      Value<double> litres,
      Value<double> cost,
      Value<double> balanceL,
      Value<int?> odometerKm,
    });

final class $$FuelTransactionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FuelTransactionsTable, FuelTransaction> {
  $$FuelTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('fuel_transactions__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<int>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $FuelTransactionsTable> {
  $$FuelTransactionsTableFilterComposer({
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

  ColumnFilters<int> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get litres => $composableBuilder(
    column: $table.litres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balanceL => $composableBuilder(
    column: $table.balanceL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelTransactionsTable> {
  $$FuelTransactionsTableOrderingComposer({
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

  ColumnOrderings<int> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get litres => $composableBuilder(
    column: $table.litres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balanceL => $composableBuilder(
    column: $table.balanceL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelTransactionsTable> {
  $$FuelTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get litres =>
      $composableBuilder(column: $table.litres, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<double> get balanceL =>
      $composableBuilder(column: $table.balanceL, builder: (column) => column);

  GeneratedColumn<int> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelTransactionsTable,
          FuelTransaction,
          $$FuelTransactionsTableFilterComposer,
          $$FuelTransactionsTableOrderingComposer,
          $$FuelTransactionsTableAnnotationComposer,
          $$FuelTransactionsTableCreateCompanionBuilder,
          $$FuelTransactionsTableUpdateCompanionBuilder,
          (FuelTransaction, $$FuelTransactionsTableReferences),
          FuelTransaction,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$FuelTransactionsTableTableManager(
    _$AppDatabase db,
    $FuelTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> vehicleId = const Value.absent(),
                Value<int> transactionDate = const Value.absent(),
                Value<double> litres = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<double> balanceL = const Value.absent(),
                Value<int?> odometerKm = const Value.absent(),
              }) => FuelTransactionsCompanion(
                id: id,
                vehicleId: vehicleId,
                transactionDate: transactionDate,
                litres: litres,
                cost: cost,
                balanceL: balanceL,
                odometerKm: odometerKm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int vehicleId,
                required int transactionDate,
                required double litres,
                required double cost,
                required double balanceL,
                Value<int?> odometerKm = const Value.absent(),
              }) => FuelTransactionsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                transactionDate: transactionDate,
                litres: litres,
                cost: cost,
                balanceL: balanceL,
                odometerKm: odometerKm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FuelTransactionsTable, FuelTransaction>(table),
                  $$FuelTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
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
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$FuelTransactionsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$FuelTransactionsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
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

typedef $$FuelTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelTransactionsTable,
      FuelTransaction,
      $$FuelTransactionsTableFilterComposer,
      $$FuelTransactionsTableOrderingComposer,
      $$FuelTransactionsTableAnnotationComposer,
      $$FuelTransactionsTableCreateCompanionBuilder,
      $$FuelTransactionsTableUpdateCompanionBuilder,
      (FuelTransaction, $$FuelTransactionsTableReferences),
      FuelTransaction,
      PrefetchHooks Function({bool vehicleId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$ComplianceLogsTableTableManager get complianceLogs =>
      $$ComplianceLogsTableTableManager(_db, _db.complianceLogs);
  $$ServiceLogsTableTableManager get serviceLogs =>
      $$ServiceLogsTableTableManager(_db, _db.serviceLogs);
  $$FuelTransactionsTableTableManager get fuelTransactions =>
      $$FuelTransactionsTableTableManager(_db, _db.fuelTransactions);
}
