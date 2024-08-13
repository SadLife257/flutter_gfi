import 'package:flutter/material.dart';
import 'package:gfi/layers/presentation/pages/AuthReDirect.dart';
import 'package:gfi/layers/presentation/widgets/onboarding_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  static const route_name = '/onboarding';

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  static final PageController _pageController = PageController(initialPage: 0);

  final double horizontalPadding = 20;
  final double verticalPadding = 15;

  List<Widget> getOnBoardingPage() {
    List<String> s = AppLocalizations.of(context)!.onboard_detail.split('#');
    List<Widget> result = [];
    for(String i in s) {
      String index = i.split('|')[0];
      String title = i.split('|')[1];;
      String detail = i.split('|')[2];;
      result.add(
          OnBoardingCard(
            image: 'assets/images/onboarding/$index.png',
            title: title,
            detail: detail,
            onPressed: () async {
              if(int.parse(index) == (s.length)) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt("onboard", 1).then((_) {
                  Navigator.pushNamed(
                    context,
                    AuthReDirect.route_name,
                  );
                });
              } else {
                _pageController.animateToPage(
                  int.parse(index),
                  duration: Durations.long1,
                  curve: Curves.linear,
                );
              }

            },
            buttonText: int.parse(index) == (s.length) ? AppLocalizations.of(context)!.finish : AppLocalizations.of(context)!.next,
            onSkipped: () {
              _pageController.animateToPage(
                s.length - 1,
                duration: Durations.long1,
                curve: Curves.linear,
              );
            },
            buttonSkipText: AppLocalizations.of(context)!.skip,
            isFinish: int.parse(index) == (s.length),
          )
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: getOnBoardingPage(),
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: getOnBoardingPage().length,
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Durations.long1,
                    curve: Curves.linear,
                  );
                },
                effect: SlideEffect(
                  spacing:  16.0,
                  radius:  8.0,
                  dotWidth:  32.0,
                  dotHeight:  16.0,
                  paintStyle:  PaintingStyle.stroke,
                  strokeWidth:  0.5,
                  dotColor: Theme.of(context).colorScheme.secondary,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
