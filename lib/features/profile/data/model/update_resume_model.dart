import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class UpdateResumeModel {
  final File? resume;

  UpdateResumeModel({this.resume});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (resume != null) {
      data['resume'] = path.basename(resume!.path);
    }
    return data;
  }

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{};
    map['resume'] = await MultipartFile.fromFile(
      resume!.path,
      filename: path.basename(resume!.path),
    );

    return FormData.fromMap(map);
  }

  factory UpdateResumeModel.fromJson(Map<String, dynamic> json) {
    return UpdateResumeModel();
  }
}
