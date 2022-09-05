import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/models/user.dart';
import 'package:flutter/material.dart';

Widget userSelectionButton({
  required UserType type,
  required UserType? selected,
  required Function(UserType) function,
}) {
  String title = type == UserType.employee ? 'Employee' : 'Employer';
  String subTitle = type == UserType.employee
      ? 'I want to get guidance, learn a new skill and apply for a job'
      : 'I want to explore new talents and hire someone to join my team';

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: GestureDetector(
      onTap: () {
        function(type);
      },
      child: AspectRatio(
        aspectRatio: 16 / 8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
              color: CColor.black,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 5,
                  color: type == selected ? CColor.red : CColor.black),
              boxShadow: [
                type == selected
                    ? BoxShadow(
                        offset: const Offset(7, 8),
                        blurRadius: 7,
                        color: CColor.black.withOpacity(0.25))
                    : BoxShadow(
                        offset: const Offset(5, 4),
                        blurRadius: 4,
                        color: CColor.black.withOpacity(0.25)),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CFont.primary(title, color: CColor.white),
              const SizedBox(height: 10),
              CFont.small(subTitle, color: CColor.white, align: TextAlign.left),
              const Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.arrow_forward_ios, color: CColor.white),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
