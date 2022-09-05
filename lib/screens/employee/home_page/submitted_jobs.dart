import 'package:employ/constants/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../../constants/custom_fonts.dart';

class ViewedJobs extends StatefulWidget {
  const ViewedJobs({Key? key}) : super(key: key);

  @override
  State<ViewedJobs> createState() => _ViewedJobsState();
}

class _ViewedJobsState extends State<ViewedJobs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CColor.white,
      child : SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CFont.primary('Submitted Job Applications'),
                const SizedBox(height: 20,),
                Container(
                  color: CColor.grey,height: 2,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
