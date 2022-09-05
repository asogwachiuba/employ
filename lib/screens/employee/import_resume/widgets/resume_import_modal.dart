import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:flutter/material.dart';

class ResumeImportModal extends StatelessWidget {
  const ResumeImportModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.5,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: CColor.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          CFont.primary('Select Resume from'),
          Row(
            children: const [Icon(Icons.storage), Icon(Icons.drive_file_move)],
          )
        ],
      ),
    );
  }
}
