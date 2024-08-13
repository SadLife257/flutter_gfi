import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/material.dart';

class DeviceSlider extends StatefulWidget {
  double value;
  DeviceSlider({
    super.key,
    required this.value,
  });

  @override
  State<DeviceSlider> createState() => _DeviceSliderState();
}

class _DeviceSliderState extends State<DeviceSlider> {
  @override
  Widget build(BuildContext context) {
    final double min = 200;
    final double max = 10000;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16
      ),
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 80,
          thumbShape: SliderComponentShape.noOverlay,
          overlayShape: SliderComponentShape.noOverlay,
          valueIndicatorShape: SliderComponentShape.noOverlay,

          trackShape: RectangularSliderTrackShape(),
          activeTrackColor: Theme.of(context).colorScheme.secondary,
          inactiveTrackColor: Theme.of(context).colorScheme.tertiary,
        ),
        child: Container(
          height: 360,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32,
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0,
                        ),
                        color: Theme.of(context).colorScheme.tertiary,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            if(widget.value > min) {
                              setState(() => widget.value -= 10);
                            }
                          },
                          icon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.keyboard_double_arrow_down,
                              size: 50,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        IconButton(
                          style: IconButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            if(widget.value > min) {
                              setState(() => widget.value -= 1);
                            }
                          },
                          icon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildSideLabel(max),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            value: widget.value,
                            min: min,
                            max: max,
                            divisions: 1000,
                            label: widget.value.round().toString(),
                            onChanged: (value) => setState(() => widget.value = value),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${widget.value.round()}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildSideLabel(min),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, widget.value.round());
                    },
                    child: Text(AppLocalizations.of(context)!.save_cap),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0,
                        ),
                        color: Theme.of(context).colorScheme.tertiary,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            if(widget.value < max) {
                              setState(() => widget.value += 10);
                            }
                          },
                          icon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.keyboard_double_arrow_up,
                              size: 50,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        IconButton(
                          style: IconButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            if(widget.value < max) {
                              setState(() => widget.value += 1);
                            }
                          },
                          icon: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.keyboard_arrow_up_outlined,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSideLabel(double value) => Text(
    value.round().toString(),
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  );
}