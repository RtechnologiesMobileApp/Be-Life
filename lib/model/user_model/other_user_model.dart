import 'package:freezed_annotation/freezed_annotation.dart';

part 'other_user_model.freezed.dart';

@freezed
abstract class OtherUserModel with _$OtherUserModel {
  const factory OtherUserModel({
    @Default(-1) int id,
    required String username,
    required String firstName,
    required String lastName,
    String? email,
    required String profilePicture,
    @Default([]) List<String> interests,
    int? followersCount,
    int? followingCount,
    int? likesCount,
    @Default(false) bool isFollowing,
    @Default(false) bool isFollowedBy,
  }) = _OtherUserModel;

  factory OtherUserModel.fromJson(Map<String, dynamic> json) {
    return OtherUserModel(
      id: json['id'] ?? -1,
      username: json['username'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'],
      profilePicture: json['profilePicture'] ?? '',
      interests: json['interests'] != null ? List<String>.from(json['interests']) : [],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      likesCount: json['likesCount'],
      isFollowing: json['isFollowing'] == 1 || json['isFollowing'] == true,
      isFollowedBy: json['isFollowedBy'] == 1 || json['isFollowedBy'] == true,
    );
  }
}
