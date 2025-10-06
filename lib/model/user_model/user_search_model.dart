import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search_model.freezed.dart';
part 'user_search_model.g.dart';

@freezed
abstract class UserSearchModel with _$UserSearchModel {
  const factory UserSearchModel({
    @Default(-1) int id,
    required String username,
    required String firstName,
    required String lastName,
    required String profilePicture,
    @Default(false) bool isFollowing,
    @Default(false) bool isFollowedBy,
  }) = _UserSearchModel;

  factory UserSearchModel.fromJson(Map<String, dynamic> json) => _$UserSearchModelFromJson(json);
}
