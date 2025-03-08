// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ProfileModelAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 0;

  @override
  ProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModel(
      id: (fields[0] as num).toInt(),
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      maidenName: fields[3] as String,
      age: (fields[4] as num).toInt(),
      gender: fields[5] as String,
      email: fields[6] as String,
      phone: fields[7] as String,
      username: fields[8] as String,
      password: fields[9] as String,
      birthDate: fields[10] as String,
      image: fields[11] as String,
      bloodGroup: fields[12] as String,
      height: (fields[13] as num).toDouble(),
      weight: (fields[14] as num).toDouble(),
      eyeColor: fields[15] as String,
      hair: fields[16] as HairModel,
      ip: fields[17] as String,
      address: fields[18] as AddressModel,
      macAddress: fields[19] as String,
      university: fields[20] as String,
      bank: fields[21] as BankModel,
      company: fields[22] as CompanyModel,
      ein: fields[23] as String,
      ssn: fields[24] as String,
      userAgent: fields[25] as String,
      crypto: fields[26] as CryptoModel,
      role: fields[27] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.maidenName)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.username)
      ..writeByte(9)
      ..write(obj.password)
      ..writeByte(10)
      ..write(obj.birthDate)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.bloodGroup)
      ..writeByte(13)
      ..write(obj.height)
      ..writeByte(14)
      ..write(obj.weight)
      ..writeByte(15)
      ..write(obj.eyeColor)
      ..writeByte(16)
      ..write(obj.hair)
      ..writeByte(17)
      ..write(obj.ip)
      ..writeByte(18)
      ..write(obj.address)
      ..writeByte(19)
      ..write(obj.macAddress)
      ..writeByte(20)
      ..write(obj.university)
      ..writeByte(21)
      ..write(obj.bank)
      ..writeByte(22)
      ..write(obj.company)
      ..writeByte(23)
      ..write(obj.ein)
      ..writeByte(24)
      ..write(obj.ssn)
      ..writeByte(25)
      ..write(obj.userAgent)
      ..writeByte(26)
      ..write(obj.crypto)
      ..writeByte(27)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HairModelAdapter extends TypeAdapter<HairModel> {
  @override
  final int typeId = 1;

  @override
  HairModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HairModel(
      color: fields[0] as String,
      type: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HairModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HairModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 2;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel(
      address: fields[0] as String,
      city: fields[1] as String,
      state: fields[2] as String,
      stateCode: fields[3] as String,
      postalCode: fields[4] as String,
      coordinates: fields[5] as CoordinatesModel,
      country: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(3)
      ..write(obj.stateCode)
      ..writeByte(4)
      ..write(obj.postalCode)
      ..writeByte(5)
      ..write(obj.coordinates)
      ..writeByte(6)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BankModelAdapter extends TypeAdapter<BankModel> {
  @override
  final int typeId = 3;

  @override
  BankModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankModel(
      cardExpire: fields[0] as String,
      cardNumber: fields[1] as String,
      cardType: fields[2] as String,
      currency: fields[3] as String,
      iban: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BankModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardExpire)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.cardType)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.iban);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyModelAdapter extends TypeAdapter<CompanyModel> {
  @override
  final int typeId = 4;

  @override
  CompanyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyModel(
      department: fields[0] as String,
      name: fields[1] as String,
      title: fields[2] as String,
      address: fields[3] as AddressModel,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.department)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CryptoModelAdapter extends TypeAdapter<CryptoModel> {
  @override
  final int typeId = 5;

  @override
  CryptoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoModel(
      coin: fields[0] as String,
      wallet: fields[1] as String,
      network: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.coin)
      ..writeByte(1)
      ..write(obj.wallet)
      ..writeByte(2)
      ..write(obj.network);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordinatesModelAdapter extends TypeAdapter<CoordinatesModel> {
  @override
  final int typeId = 6;

  @override
  CoordinatesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoordinatesModel(
      lat: (fields[0] as num).toDouble(),
      lng: (fields[1] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, CoordinatesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinatesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 7;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      todos: (fields[0] as List?)?.cast<TodoDetailsModel>(),
      total: (fields[1] as num?)?.toInt(),
      skip: (fields[2] as num?)?.toInt(),
      limit: (fields[3] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.todos)
      ..writeByte(1)
      ..write(obj.total)
      ..writeByte(2)
      ..write(obj.skip)
      ..writeByte(3)
      ..write(obj.limit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoDetailsModelAdapter extends TypeAdapter<TodoDetailsModel> {
  @override
  final int typeId = 8;

  @override
  TodoDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoDetailsModel(
      id: (fields[0] as num?)?.toInt(),
      todo: fields[1] as String?,
      completed: fields[2] as bool,
      userId: (fields[3] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoDetailsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.todo)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
