// FutureBuilder<List<JobApplicationModel>>(
// future: jobPostsProvider.getListOfJobApplications(jobPostId),
// builder: (context, snapshot) {
// print(snapshot.data);
// switch (snapshot.connectionState) {
// case ConnectionState.waiting:
// return const CircularProgressIndicator(
// color: CColor.black,
// );
//
// case ConnectionState.done:
// default:
// if (snapshot.hasError) {
// final error = snapshot.error;
// return Center(
// child: ConstrainedBox(
// child: CFont.darkSecondary(
// 'This error occurred: $error'),
// constraints: BoxConstraints(
// maxWidth: MediaQuery
//     .of(context)
//     .size
//     .width),
// ),
// );
// }
//
// if (snapshot.hasData) {
// List<JobApplicationModel> listOfJobApplications =
// snapshot.data!;
//
// listOfJobApplications.isEmpty
// ? Center(
// child: CFont.darkSecondary(
// 'No available job application currently in the list'),
// )
//     : ListView.builder(
// physics: const BouncingScrollPhysics(),
// shrinkWrap: true,
// itemCount: listOfJobApplications.length,
// itemBuilder: (context, index) {
// return SizedBox(
// height: 40,
// child: Row(
// children: [
// ClipOval(
// child: listOfJobApplications[index]
//     .applicantProfileUrl == null
// ? const CircleAvatar(
// backgroundColor: CColor.black,
// child: Icon(
// Icons.person,
// color: CColor.white,
// size: 40,
// ),
// )
//     : Image.network(
// listOfJobApplications[index]
//     .applicantProfileUrl!,
// width: 200,
// height: 200,
// ),
// ),
// const SizedBox(width: 20,),
// CFont.smallerPrimary(
// '${listOfJobApplications[index]
//     .applicantProfileUrl}s')
// ],
// ),
// );
// },
// );
// }
//
// return CFont.darkSecondary(
// 'No available job applications currently ');
// }
//
// })