import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class UpdatePersonalInfoModel {
  final String? fullName;
  final String? biography;
  final String? gender;
  final int? selectedCityId;
  final File? picture;
  final String? birthDate;

  UpdatePersonalInfoModel({
    this.fullName,
    this.biography,
    this.gender,
    this.selectedCityId,
    this.picture,
    this.birthDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (fullName != null) data['full_name'] = fullName;
    if (biography != null) data['biography'] = biography;
    if (gender != null) data['gender'] = gender;
    if (selectedCityId != null) data['selected_city_id'] = selectedCityId;
    if (birthDate != null) data['birth_date'] = birthDate;

    return data;
  }

  Future<FormData> toFormData() async {
    final map = toJson();
    if (picture != null) {
      map['picture'] = await MultipartFile.fromFile(
        picture!.path,
        filename: path.basename(picture!.path),
      );
    }
    return FormData.fromMap(map);
  }

  factory UpdatePersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return UpdatePersonalInfoModel(
      fullName: json['full_name'] as String?,
      biography: json['biography'] as String?,
      gender: json['gender'] as String?,
      selectedCityId: json['selected_city_id'] as int?,
      birthDate: json['birth_date'] as String?,
    );
  }
}
