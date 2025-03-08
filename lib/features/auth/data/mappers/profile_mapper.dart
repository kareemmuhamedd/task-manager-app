import '../../domain/entities/profile_entity.dart';
import '../models/profile_model.dart';

class ProfileMapper {
  static ProfileEntity fromModel(ProfileModel model) {
    return ProfileEntity(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      maidenName: model.maidenName,
      age: model.age,
      gender: model.gender,
      email: model.email,
      phone: model.phone,
      username: model.username,
      password: model.password,
      birthDate: DateTime.tryParse(model.birthDate) ?? DateTime(1970, 1, 1),
      image: model.image,
      bloodGroup: model.bloodGroup,
      height: model.height,
      weight: model.weight,
      eyeColor: model.eyeColor,
      hair: HairMapper.fromModel(model.hair),
      ip: model.ip,
      address: AddressMapper.fromModel(model.address),
      macAddress: model.macAddress,
      university: model.university,
      bank: BankMapper.fromModel(model.bank),
      company: CompanyMapper.fromModel(model.company),
      ein: model.ein,
      ssn: model.ssn,
      userAgent: model.userAgent,
      crypto: CryptoMapper.fromModel(model.crypto),
      role: model.role,
    );
  }

  static ProfileModel toModel(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      maidenName: entity.maidenName,
      age: entity.age,
      gender: entity.gender,
      email: entity.email,
      phone: entity.phone,
      username: entity.username,
      password: entity.password,
      birthDate: entity.birthDate.toIso8601String(),
      image: entity.image,
      bloodGroup: entity.bloodGroup,
      height: entity.height,
      weight: entity.weight,
      eyeColor: entity.eyeColor,
      hair: HairMapper.toModel(entity.hair),
      ip: entity.ip,
      address: AddressMapper.toModel(entity.address),
      macAddress: entity.macAddress,
      university: entity.university,
      bank: BankMapper.toModel(entity.bank),
      company: CompanyMapper.toModel(entity.company),
      ein: entity.ein,
      ssn: entity.ssn,
      userAgent: entity.userAgent,
      crypto: CryptoMapper.toModel(entity.crypto),
      role: entity.role,
    );
  }
}

class HairMapper {
  static HairEntity fromModel(HairModel model) {
    return HairEntity(color: model.color, type: model.type);
  }

  static HairModel toModel(HairEntity entity) {
    return HairModel(color: entity.color, type: entity.type);
  }
}

class AddressMapper {
  static AddressEntity fromModel(AddressModel model) {
    return AddressEntity(
      address: model.address,
      city: model.city,
      state: model.state,
      stateCode: model.stateCode,
      postalCode: model.postalCode,
      coordinates: CoordinatesMapper.fromModel(model.coordinates),
      country: model.country,
    );
  }

  static AddressModel toModel(AddressEntity entity) {
    return AddressModel(
      address: entity.address,
      city: entity.city,
      state: entity.state,
      stateCode: entity.stateCode,
      postalCode: entity.postalCode,
      coordinates: CoordinatesMapper.toModel(entity.coordinates),
      country: entity.country,
    );
  }
}

class CoordinatesMapper {
  static CoordinatesEntity fromModel(CoordinatesModel model) {
    return CoordinatesEntity(lat: model.lat, lng: model.lng);
  }

  static CoordinatesModel toModel(CoordinatesEntity entity) {
    return CoordinatesModel(lat: entity.lat, lng: entity.lng);
  }
}

class BankMapper {
  static BankEntity fromModel(BankModel model) {
    return BankEntity(
      cardExpire: model.cardExpire,
      cardNumber: model.cardNumber,
      cardType: model.cardType,
      currency: model.currency,
      iban: model.iban,
    );
  }

  static BankModel toModel(BankEntity entity) {
    return BankModel(
      cardExpire: entity.cardExpire,
      cardNumber: entity.cardNumber,
      cardType: entity.cardType,
      currency: entity.currency,
      iban: entity.iban,
    );
  }
}

class CompanyMapper {
  static CompanyEntity fromModel(CompanyModel model) {
    return CompanyEntity(
      department: model.department,
      name: model.name,
      title: model.title,
      address: AddressMapper.fromModel(model.address),
    );
  }

  static CompanyModel toModel(CompanyEntity entity) {
    return CompanyModel(
      department: entity.department,
      name: entity.name,
      title: entity.title,
      address: AddressMapper.toModel(entity.address),
    );
  }
}

class CryptoMapper {
  static CryptoEntity fromModel(CryptoModel model) {
    return CryptoEntity(
      coin: model.coin,
      wallet: model.wallet,
      network: model.network,
    );
  }

  static CryptoModel toModel(CryptoEntity entity) {
    return CryptoModel(
      coin: entity.coin,
      wallet: entity.wallet,
      network: entity.network,
    );
  }
}
