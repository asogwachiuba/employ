import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/constants/custom_images.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:go_router/go_router.dart';

class SelectUserType extends StatefulWidget {
  const SelectUserType({Key? key}) : super(key: key);

  @override
  _SelectUserTypeState createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  late List<String>? userInfo = [];
  final PageController _controller = PageController();
  String _buttonText = 'Next';
  int _pageIndex = 0;

  void _buttonClick() {
    if (_pageIndex == 2) {
      _nextPage();
      return;
    }
    _controller.animateToPage(_pageIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
  }

  void _nextPage() {
    context.go('/select_user');
  }
  getPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userInfo = preferences.getStringList('userIdInfo');
  }

  @override
  void initState() {
    super.initState();
    getPreference();
  }

  @override
  Widget build(BuildContext context) {
  //  if(userInfo!.isEmpty) NavigationMethods().toEmployeesSignInPage(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              _pageIndex = index;
              if (index == 2) {
                setState(() {
                  _buttonText = 'Let\'s go';
                });
              } else {
                setState(() {
                  _buttonText = 'Next';
                });
              }
            },
            children: [
              introPage(CImg.collaborate, 'Hire Top Talents',
                  'Sign up to connect and hire for your next project'),
              introPage(CImg.intouch, 'Getting Started is Super Easy',
                  'Instantly build your profile, learn and apply for your next job remotely'),
              introPage(CImg.backed, 'Personalized just for you',
                  'We believe the world is much beautiful as each person gets better')
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                  strokeWidth: 2.0,
                  activeDotColor: Colors.black,
                )),
          ),
          Align(
              alignment: const Alignment(0, 0.75),
              child: CButton.primary(
                  text: _buttonText,
                  onPressed: () {
                    _buttonClick();
                  })),
        ],
      ),
    );
  }

  Widget introPage(String imgUrl, String title, String message) {
    return Column(
      children: [
        const Spacer(flex: 2),
        SvgPicture.asset(imgUrl),
        CFont.primary(title),
        CFont.small(message),
        const Spacer(flex: 3),
      ],
    );
  }
}
