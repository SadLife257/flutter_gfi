import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceScrollWheel extends StatelessWidget {
  final String name;
  final int initialItem;
  final List<int> relay_list;
  final Function(int)? onSelectedItemChanged;
  double borderWidth;
  double borderRadius;

  DeviceScrollWheel({
    super.key,
    required this.name,
    required this.initialItem,
    required this.relay_list,
    required this.onSelectedItemChanged,
    this.borderWidth = 0.5,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: borderWidth),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: CupertinoPicker(
                itemExtent: 60,
                onSelectedItemChanged: onSelectedItemChanged,
                children: List<Widget>.generate(relay_list.length, (int index) {
                  return Center(
                    child: Text(
                      relay_list[index].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  );
                }),
                scrollController: FixedExtentScrollController(
                  initialItem: initialItem
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
