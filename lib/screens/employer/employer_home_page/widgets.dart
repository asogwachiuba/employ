import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/custom_colors.dart';
import '../../../constants/custom_fonts.dart';

class EmployerHomePageWidgets {


  static Widget postedJobTile({
    required BuildContext context,
    required String jobTitle,
    required String companyName,
    required String companyLocation,
    required String jobPostId,
    String? datePosted,
    String? deadline
  }) {
    return Card(
      margin: EdgeInsets.all(20),
      shadowColor: CColor.black,
      elevation: 20,
      color: CColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 250, width: MediaQuery
          .of(context)
          .size
          .width * 0.85,
        child: Column(
          children: [
            CFont.primary(jobTitle),
            CFont.secondary(companyName),
            CFont.secondary(companyLocation),
            CFont.primary(datePosted ?? 'Not Available'),
            CFont.secondary(deadline ?? 'Not Available'),
            Spacer(flex: 1,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Chip(
                  label: CFont.small('Delete', color: CColor.black),
                  deleteIcon: Icon(Icons.delete, size: 20,),
                  elevation: 5,
                  deleteIconColor: CColor.black,
                  onDeleted: () {},),
                Chip(
                  label: CFont.small('Update', color: CColor.black),
                  elevation: 5,
                  deleteIcon: Icon(Icons.update, size: 20),
                  deleteIconColor: CColor.black,
                  onDeleted: () {},),
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}