import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  static const route_name = '/about_us';

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Text(
            'About Us',
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
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 25,
              ),
              child: Text(
                'GFI - Gas and Fire Intelligence is our team Infomation Technology Project to improve fire safety for family and businesses by offering an insight into their temperature, gas concentration, etc, ... remotely through their devices.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'This Project',
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
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 25,
              ),
              child: Text(
                'This app is a part of our project which uses platforms like Android and iOS to provide our service to hand-held devices aiming for family members.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Our Team',
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Lâm Quốc Huy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          '52000216@student.tdtu.edu.vn',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Computer Science',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Tôn Đức Thắng University',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Nguyễn Lê Gia Bảo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          '52000632@student.tdtu.edu.vn',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Software Technology',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Tôn Đức Thắng University',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 25,
              ),
              child: Text(
                'Our team consists of two members Lâm Quốc Huy, majoring in Computer Science at Tôn Đức Thắng University, and Nguyễn Lê Gia Bảo, majoring in Software Technology at Tôn Đức Thắng University. ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
