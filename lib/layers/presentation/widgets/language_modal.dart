import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LanguageModal extends StatelessWidget {
  const LanguageModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              AppLocalizations.of(context)!.setting_language_label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              child: Text(
                AppLocalizations.of(context)!.setting_language("en"),
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary
                ),
              ),
              onTap: () {
                Navigator.pop(context, "en");
              }
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
                child: Text(
                  AppLocalizations.of(context)!.setting_language("vi"),
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, "vi");
                }
            ),
          )
        ],
      ),
    );
  }
}
