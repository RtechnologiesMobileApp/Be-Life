import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @Default(-1)  int id,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    @JsonKey(fromJson: _fromJsonDob, toJson: _toJsonDob)
    required DateTime dob,
    required String phoneNumber,
    required List<String> interests,
    required String profilePicture,
     String? bio,
     String? password,
     int? followersCount,
     int? followingCount,
     int? likesCount,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
DateTime _fromJsonDob(String date) => DateTime.parse(date);
String _toJsonDob(DateTime date) => DateFormat('yyyy-MM-dd').format(date);