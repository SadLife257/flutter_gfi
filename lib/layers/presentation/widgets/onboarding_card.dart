import 'package:flutter/material.dart';

class OnBoardingCard extends StatelessWidget {
  final String image;
  final String title;
  final String detail;
  final Function() onPressed;
  final String buttonText;
  final bool isFinish;
  final Function() onSkipped;
  final String buttonSkipText;

  OnBoardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.detail,
    required this.onPressed,
    required this.buttonText,
    required this.onSkipped,
    required this.buttonSkipText,
    required this.isFinish,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var dim = MediaQuery.of(context).size;

    return Container(
      width: dim.width,
      height: dim.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            fit: BoxFit.contain,
            height: dim.height * 0.8 * 0.5,
          ),
          SizedBox(
            height: dim.height * 0.8 * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: theme.primary,
                  ),
                ),
                Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: theme.tertiary,
                minimumSize: Size.fromHeight(60),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
              ),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ),
          Opacity(
            opacity: isFinish ? 0 : 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.secondary,
                  foregroundColor: theme.primary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                ),
                onPressed: onSkipped,
                child: Text(buttonSkipText),
              ),
            ),
          ),
          // Visibility(
          //   visible: !isFinish,
          //   child: Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: theme.secondary,
          //         foregroundColor: theme.primary,
          //         minimumSize: Size.fromHeight(60),
          //         shape: const RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(16))
          //         ),
          //       ),
          //       onPressed: onSkipped,
          //       child: Text(buttonSkipText),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
