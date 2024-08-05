import 'package:flutter/material.dart';

class DeviceDropDown extends StatelessWidget {
  final String name;
  final String option;
  final List<String> option_list;
  void Function(String?)? onChanged;
  Color backgroundColor;
  double borderWidth;

  DeviceDropDown({
    super.key,
    required this.name,
    required this.option,
    required this.option_list,
    required this.onChanged,
    this.backgroundColor = Colors.black,
    this.borderWidth = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: backgroundColor, width: borderWidth),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              DropdownButton<String>(
                value: option,
                onChanged: onChanged,
                items: option_list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
