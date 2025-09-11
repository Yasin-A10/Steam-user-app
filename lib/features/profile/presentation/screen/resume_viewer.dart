import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String? filePath;
  final String? fileUrl;

  const PdfViewerScreen({super.key, this.filePath, this.fileUrl})
    : assert(
        filePath != null || fileUrl != null,
        'Either filePath or fileUrl must be provided',
      ); // for testing

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('نمایش PDF'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
      ),
      body: filePath != null
          ? SfPdfViewer.file(File(filePath!)) // from local file
          : SfPdfViewer.network(fileUrl!), // from url
    );
  }
}
