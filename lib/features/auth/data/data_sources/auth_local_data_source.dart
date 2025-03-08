// profile_local_data_source.dart
import 'package:hive_ce/hive.dart';

import '../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel?> getProfile();

  Future<void> saveProfile(ProfileModel profile);

  Future<void> clearProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Box<ProfileModel> profileBox;

  ProfileLocalDataSourceImpl(this.profileBox);

  @override
  Future<ProfileModel?> getProfile() async {
    if (profileBox.isNotEmpty) {
      return profileBox.getAt(0);
    }
    return null;
  }

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    await profileBox.clear();
    await profileBox.add(profile);
  }

  @override
  Future<void> clearProfile() async {
    await profileBox.clear();
  }
}
