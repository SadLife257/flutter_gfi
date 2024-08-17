import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:gfi/layers/domain/entities/Notifier/Locale.dart';
import 'package:gfi/layers/domain/entities/Notifier/Theme.dart';
import 'package:gfi/layers/presentation/pages/room/RoomCreate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  static const route_name = '/setting';

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var selectedLocale = Localizations.localeOf(context).toString();
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.setting,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 30,
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      AppLocalizations.of(context)!.manage_home,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.tertiary,
                    minimumSize: Size.fromHeight(60),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context,
                        RoomCreate.route_name,
                    );
                  },
                  label: Text(AppLocalizations.of(context)!.add_room),
                  icon: Icon(Icons.add_home_outlined),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                        AppLocalizations.of(context)!.manage_app,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Consumer<LocaleProvider>(
                  builder: (context, localeProvider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16
                      ),
                      child: DropdownButton(
                        dropdownColor: Theme.of(context).colorScheme.primary,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color:Theme.of(context).colorScheme.tertiary,
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                        value: selectedLocale,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              AppLocalizations.of(context)!.setting_language("en"),
                            ),
                            value: "en",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              AppLocalizations.of(context)!.setting_language("vi"),
                            ),
                            value: "vi",
                          ),

                        ],
                        onChanged: (String? value) async {
                          if (value != null) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString("locale", value).then((_) {
                              setState(() {

                              });
                            });
                            localeProvider.set(Locale(value));
                          }
                        },
                      ),
                    );
                  }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      var selectedTheme = themeProvider.isDarkMode() ? "dark" : "light";
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16
                        ),
                        child: DropdownButton(
                          dropdownColor: Theme.of(context).colorScheme.primary,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color:Theme.of(context).colorScheme.tertiary,
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                          value: selectedTheme,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                AppLocalizations.of(context)!.setting_theme("dark"),
                              ),
                              value: "dark",
                            ),
                            DropdownMenuItem(
                              child: Text(
                                AppLocalizations.of(context)!.setting_theme("light"),
                              ),
                              value: "light",
                            ),

                          ],
                          onChanged: (String? value) async {
                            if (value != null) {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setInt("isDarkMode", value == "dark" ? 1 : 0).then((_) {
                                setState(() {

                                });
                              });
                              themeProvider.set(value == "dark");
                            }
                          },
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
