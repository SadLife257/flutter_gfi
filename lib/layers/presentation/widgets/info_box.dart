import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  Color borderColor;
  Color backgroundColor;
  Color titleColor;
  Color detailColor;
  Color iconColor;
  bool isChangeable;
  final String title;
  final String? detail;

  InfoBox({
    super.key,
    this.titleColor = Colors.white,
    this.detailColor = Colors.white,
    this.iconColor = Colors.white,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.isChangeable = false,
    required this.title,
    this.detail
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 2),
      ),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isChangeable ? 8 : 24
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: titleColor
                  ),
                ),
                Visibility(
                  visible: isChangeable,
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.settings, color: iconColor,),
                  ),
                )
              ],
            ),
          ),
          detail != null ? Text(
            detail!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: detailColor
            ),
          ) : Text(
            '*********',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: detailColor
            ),
          ),
          // TextFormField(
          //   style: TextStyle(
          //       color: Theme.of(context).colorScheme.primary
          //   ),
          //   decoration: InputDecoration(
          //     hintText: 'Email',
          //     labelText: 'Email',
          //     hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          //     labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          //     border: OutlineInputBorder(
          //       borderSide:
          //       BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
          //       borderRadius: BorderRadius.all(Radius.circular(16)),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide:
          //       BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
          //       borderRadius: BorderRadius.all(Radius.circular(16)),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide:
          //       BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
          //       borderRadius: BorderRadius.all(Radius.circular(16)),
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return "Please enter your email";
          //     }
          //     return null;
          //   },
          // ),
        ],
      ),
    );
  }
}
