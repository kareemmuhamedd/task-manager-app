import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final DateTime birthDate;
  final String image;
  final String bloodGroup;
  final double height;
  final double weight;
  final String eyeColor;
  final HairEntity hair;
  final String ip;
  final AddressEntity address;
  final String macAddress;
  final String university;
  final BankEntity bank;
  final CompanyEntity company;
  final String ein;
  final String ssn;
  final String userAgent;
  final CryptoEntity crypto;
  final String role;

  const ProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
    required this.crypto,
    required this.role,
  });

  ProfileEntity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? maidenName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? username,
    String? password,
    DateTime? birthDate,
    String? image,
    String? bloodGroup,
    double? height,
    double? weight,
    String? eyeColor,
    HairEntity? hair,
    String? ip,
    AddressEntity? address,
    String? macAddress,
    String? university,
    BankEntity? bank,
    CompanyEntity? company,
    String? ein,
    String? ssn,
    String? userAgent,
    CryptoEntity? crypto,
    String? role,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      maidenName: maidenName ?? this.maidenName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      image: image ?? this.image,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      eyeColor: eyeColor ?? this.eyeColor,
      hair: hair ?? this.hair,
      ip: ip ?? this.ip,
      address: address ?? this.address,
      macAddress: macAddress ?? this.macAddress,
      university: university ?? this.university,
      bank: bank ?? this.bank,
      company: company ?? this.company,
      ein: ein ?? this.ein,
      ssn: ssn ?? this.ssn,
      userAgent: userAgent ?? this.userAgent,
      crypto: crypto ?? this.crypto,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [id, email, username];
}

class HairEntity extends Equatable {
  final String color;
  final String type;

  const HairEntity({required this.color, required this.type});

  HairEntity copyWith({String? color, String? type}) {
    return HairEntity(
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [color, type];
}

class AddressEntity extends Equatable {
  final String address;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final CoordinatesEntity coordinates;
  final String country;

  const AddressEntity({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.coordinates,
    required this.country,
  });

  AddressEntity copyWith({
    String? address,
    String? city,
    String? state,
    String? stateCode,
    String? postalCode,
    CoordinatesEntity? coordinates,
    String? country,
  }) {
    return AddressEntity(
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      stateCode: stateCode ?? this.stateCode,
      postalCode: postalCode ?? this.postalCode,
      coordinates: coordinates ?? this.coordinates,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [address, city, state, postalCode, country];
}

class CoordinatesEntity extends Equatable {
  final double lat;
  final double lng;

  const CoordinatesEntity({required this.lat, required this.lng});

  CoordinatesEntity copyWith({double? lat, double? lng}) {
    return CoordinatesEntity(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}

class BankEntity extends Equatable {
  final String cardExpire;
  final String cardNumber;
  final String cardType;
  final String currency;
  final String iban;

  const BankEntity({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  BankEntity copyWith({
    String? cardExpire,
    String? cardNumber,
    String? cardType,
    String? currency,
    String? iban,
  }) {
    return BankEntity(
      cardExpire: cardExpire ?? this.cardExpire,
      cardNumber: cardNumber ?? this.cardNumber,
      cardType: cardType ?? this.cardType,
      currency: currency ?? this.currency,
      iban: iban ?? this.iban,
    );
  }

  @override
  List<Object?> get props => [cardNumber, iban];
}

class CompanyEntity extends Equatable {
  final String department;
  final String name;
  final String title;
  final AddressEntity address;

  const CompanyEntity({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });

  CompanyEntity copyWith({
    String? department,
    String? name,
    String? title,
    AddressEntity? address,
  }) {
    return CompanyEntity(
      department: department ?? this.department,
      name: name ?? this.name,
      title: title ?? this.title,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [department, name, title];
}

class CryptoEntity extends Equatable {
  final String coin;
  final String wallet;
  final String network;

  const CryptoEntity({required this.coin, required this.wallet, required this.network});

  CryptoEntity copyWith({String? coin, String? wallet, String? network}) {
    return CryptoEntity(
      coin: coin ?? this.coin,
      wallet: wallet ?? this.wallet,
      network: network ?? this.network,
    );
  }

  @override
  List<Object?> get props => [coin, wallet, network];
}
