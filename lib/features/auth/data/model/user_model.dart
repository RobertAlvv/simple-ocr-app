import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.displayName,
    super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    id: entity.id,
    email: entity.email,
    displayName: entity.displayName,
    photoUrl: entity.photoUrl,
  );
}
