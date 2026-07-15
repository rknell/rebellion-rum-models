// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distillation_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistillationRecordModel _$DistillationRecordModelFromJson(
        Map<String, dynamic> json) =>
    DistillationRecordModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      stillUsed: json['stillUsed'] as String? ?? '',
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      distillationDate: json['distillationDate'] == null
          ? null
          : DateTime.parse(json['distillationDate'] as String),
      status:
          $enumDecodeNullable(_$DistillationStatusEnumMap, json['status']) ??
              DistillationStatus.inProgress,
      chargeNumber: (json['chargeNumber'] as num?)?.toInt() ?? 0,
      alcoholType: $enumDecodeNullable(
              _$DistillationAlcoholTypeEnumMap, json['alcoholType']) ??
          DistillationAlcoholType.rum,
      alcoholTypeOther: json['alcoholTypeOther'] as String?,
      feintsAdded: (json['feintsAdded'] as num?)?.toDouble() ?? 0,
      lalsCharged: (json['lalsCharged'] as num?)?.toDouble() ?? 0,
      totalLALsCharged: (json['totalLALsCharged'] as num?)?.toDouble() ?? 0,
      totalLALsYield: (json['totalLALsYield'] as num?)?.toDouble() ?? 0,
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..ginStillStocktake = json['ginStillStocktake'] == null
        ? null
        : GinStillStocktakeModel.fromJson(
            json['ginStillStocktake'] as Map<String, dynamic>);

Map<String, dynamic> _$DistillationRecordModelToJson(
        DistillationRecordModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'stillUsed': instance.stillUsed,
      'startTime': instance.startTime.toIso8601String(),
      'distillationDate': instance.distillationDate.toIso8601String(),
      'status': _$DistillationStatusEnumMap[instance.status]!,
      'chargeNumber': instance.chargeNumber,
      'alcoholType': _$DistillationAlcoholTypeEnumMap[instance.alcoholType]!,
      if (instance.alcoholTypeOther case final value?)
        'alcoholTypeOther': value,
      'feintsAdded': instance.feintsAdded,
      'lalsCharged': instance.lalsCharged,
      'totalLALsCharged': instance.totalLALsCharged,
      'totalLALsYield': instance.totalLALsYield,
      'notes': instance.notes.map((e) => e.toJson()).toList(),
      if (instance.ginStillStocktake?.toJson() case final value?)
        'ginStillStocktake': value,
    };

const _$DistillationStatusEnumMap = {
  DistillationStatus.inProgress: 'inProgress',
  DistillationStatus.completed: 'completed',
  DistillationStatus.archived: 'archived',
};

const _$DistillationAlcoholTypeEnumMap = {
  DistillationAlcoholType.rum: 'rum',
  DistillationAlcoholType.gin: 'gin',
  DistillationAlcoholType.vodka: 'vodka',
  DistillationAlcoholType.whisky: 'whisky',
  DistillationAlcoholType.brandy: 'brandy',
  DistillationAlcoholType.liqueur: 'liqueur',
  DistillationAlcoholType.neutralSpirit: 'neutralSpirit',
  DistillationAlcoholType.other: 'other',
};

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      content: json['content'] as String,
      date: jsonToDateTime(json['date']),
      isSystem: json['isSystem'] as bool? ?? false,
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'content': instance.content,
      'date': dateTimeToJson(instance.date),
      'isSystem': instance.isSystem,
    };

GinStillStocktakeModel _$GinStillStocktakeModelFromJson(
        Map<String, dynamic> json) =>
    GinStillStocktakeModel(
      height: (json['height'] as num).toDouble(),
      abv: (json['abv'] as num).toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble() ?? 20,
    );

Map<String, dynamic> _$GinStillStocktakeModelToJson(
        GinStillStocktakeModel instance) =>
    <String, dynamic>{
      'height': instance.height,
      'abv': instance.abv,
      'temperature': instance.temperature,
    };
