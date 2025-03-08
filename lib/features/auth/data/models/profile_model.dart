import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';


class ProfileModel extends HiveObject with EquatableMixin {
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
  final String birthDate;
  final String image;
  final String bloodGroup;
  final double height;
  final double weight;
  final String eyeColor;
  final HairModel hair;
  final String ip;
  final AddressModel address;
  final String macAddress;
  final String university;
  final BankModel bank;
  final CompanyModel company;
  final String ein;
  final String ssn;
  final String userAgent;
  final CryptoModel crypto;
  final String role;

  ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    maidenName: json["maidenName"],
    age: json["age"],
    gender: json["gender"],
    email: json["email"],
    phone: json["phone"],
    username: json["username"],
    password: json["password"],
    birthDate: json["birthDate"],
    image: json["image"],
    bloodGroup: json["bloodGroup"],
    height: json["height"].toDouble(),
    weight: json["weight"].toDouble(),
    eyeColor: json["eyeColor"],
    hair: HairModel.fromJson(json["hair"]),
    ip: json["ip"],
    address: AddressModel.fromJson(json["address"]),
    macAddress: json["macAddress"],
    university: json["university"],
    bank: BankModel.fromJson(json["bank"]),
    company: CompanyModel.fromJson(json["company"]),
    ein: json["ein"],
    ssn: json["ssn"],
    userAgent: json["userAgent"],
    crypto: CryptoModel.fromJson(json["crypto"]),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "maidenName": maidenName,
    "age": age,
    "gender": gender,
    "email": email,
    "phone": phone,
    "username": username,
    "password": password,
    "birthDate": birthDate,
    "image": image,
    "bloodGroup": bloodGroup,
    "height": height,
    "weight": weight,
    "eyeColor": eyeColor,
    "hair": hair.toJson(),
    "ip": ip,
    "address": address.toJson(),
    "macAddress": macAddress,
    "university": university,
    "bank": bank.toJson(),
    "company": company.toJson(),
    "ein": ein,
    "ssn": ssn,
    "userAgent": userAgent,
    "crypto": crypto.toJson(),
    "role": role,
  };

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    maidenName,
    age,
    gender,
    email,
    phone,
    username,
    password,
    birthDate,
    image,
    bloodGroup,
    height,
    weight,
    eyeColor,
    hair,
    ip,
    address,
    macAddress,
    university,
    bank,
    company,
    ein,
    ssn,
    userAgent,
    crypto,
    role,
  ];
}

class HairModel extends HiveObject {
  final String color;
  final String type;

  HairModel({required this.color, required this.type});

  factory HairModel.fromJson(Map<String, dynamic> json) =>
      HairModel(color: json["color"], type: json["type"]);

  Map<String, dynamic> toJson() => {"color": color, "type": type};
}

class AddressModel extends HiveObject {
  final String address;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final CoordinatesModel coordinates;
  final String country;

  AddressModel({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.coordinates,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        address: json["address"],
        city: json["city"],
        state: json["state"],
        stateCode: json["stateCode"],
        postalCode: json["postalCode"],
        coordinates: CoordinatesModel.fromJson(json["coordinates"]),
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "state": state,
        "stateCode": stateCode,
        "postalCode": postalCode,
        "coordinates": coordinates.toJson(),
        "country": country,
      };
}

class CoordinatesModel extends HiveObject {
  final double lat;
  final double lng;

  CoordinatesModel({required this.lat, required this.lng});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      CoordinatesModel(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};
}

class BankModel extends HiveObject {
  final String cardExpire;
  final String cardNumber;
  final String cardType;
  final String currency;
  final String iban;

  BankModel({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        cardExpire: json["cardExpire"],
        cardNumber: json["cardNumber"],
        cardType: json["cardType"],
        currency: json["currency"],
        iban: json["iban"],
      );

  Map<String, dynamic> toJson() => {
        "cardExpire": cardExpire,
        "cardNumber": cardNumber,
        "cardType": cardType,
        "currency": currency,
        "iban": iban,
      };
}

class CompanyModel extends HiveObject {
  final String department;
  final String name;
  final String title;
  final AddressModel address;

  CompanyModel({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        department: json["department"],
        name: json["name"],
        title: json["title"],
        address: AddressModel.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "department": department,
        "name": name,
        "title": title,
        "address": address.toJson(),
      };
}


class CryptoModel extends HiveObject {
  final String coin;
  final String wallet;
  final String network;

  CryptoModel(
      {required this.coin, required this.wallet, required this.network});

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
        coin: json["coin"],
        wallet: json["wallet"],
        network: json["network"],
      );

  Map<String, dynamic> toJson() => {
        "coin": coin,
        "wallet": wallet,
        "network": network,
      };
}
