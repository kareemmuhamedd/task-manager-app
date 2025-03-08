import 'package:management_tasks_app/features/auth/data/models/auth_model.dart';
import 'package:management_tasks_app/features/auth/domain/entities/auth_entity.dart';

class AuthMapper {
  static AuthModel fromEntity(AuthEntity entity) {
    return AuthModel(
      id: entity.id,
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      username: entity.username,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      gender: entity.gender,
      image: entity.image,
    );
  }

  static AuthEntity toEntity(AuthModel model) {
    return AuthEntity(
      id: model.id,
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
      username: model.username,
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      gender: model.gender,
      image: model.image,
    );
  }
}
