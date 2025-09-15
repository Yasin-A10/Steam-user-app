import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class GetNameModel {
  final String? fullName;
  final File? picture;

  GetNameModel({this.fullName, this.picture});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (fullName != null) data['full_name'] = fullName;

    return data;
  }

  Future<FormData> toFormData() async {
    final map = toJson();

    map['picture'] = await MultipartFile.fromFile(
      picture!.path,
      filename: path.basename(picture!.path),
    );
    return FormData.fromMap(map);
  }

  factory GetNameModel.fromJson(Map<String, dynamic> json) {
    return GetNameModel(fullName: json['full_name'] as String?);
  }
}
