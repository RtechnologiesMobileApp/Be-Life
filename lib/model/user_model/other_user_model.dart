import 'package:freezed_annotation/freezed_annotation.dart';

part 'other_user_model.freezed.dart';
part 'other_user_model.g.dart';

@freezed
abstract class OtherUserModel with _$OtherUserModel {
  const factory OtherUserModel({
    @Default(-1) int id,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String profilePicture,
    required List<String> interests,
    int? followersCount,
    int? followingCount,
    int? likesCount,
    @Default(false) bool isFollowing,
    @Default(false) bool isFollowedBy,
  }) = _OtherUserModel;

  factory OtherUserModel.fromJson(Map<String, dynamic> json) => _$OtherUserModelFromJson(json);
}
