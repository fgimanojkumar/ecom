// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 3;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      userId: fields[0] as String?,
      password: fields[1] as String?,
      partnerType: fields[2] as String?,
      appPin: fields[3] as String?,
      username: fields[4] as String?,
      mobile: fields[5] as String?,
      preferredLanguage: fields[6] as String?,
      surveyorCode: fields[7] as String?,
      liscenceSurveyorGcn: fields[8] as String?,
      surveyorRole: fields[9] as String?,
      token: fields[10] as String?,
      fcmId: fields[11] as String?,
      lastServerLogin: fields[12] as String?,
      lastLocalLogin: fields[13] as String?,
      updatedAt: fields[14] as String?,
      createdAt: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.partnerType)
      ..writeByte(3)
      ..write(obj.appPin)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.mobile)
      ..writeByte(6)
      ..write(obj.preferredLanguage)
      ..writeByte(7)
      ..write(obj.surveyorCode)
      ..writeByte(8)
      ..write(obj.liscenceSurveyorGcn)
      ..writeByte(9)
      ..write(obj.surveyorRole)
      ..writeByte(10)
      ..write(obj.token)
      ..writeByte(11)
      ..write(obj.fcmId)
      ..writeByte(12)
      ..write(obj.lastServerLogin)
      ..writeByte(13)
      ..write(obj.lastLocalLogin)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
