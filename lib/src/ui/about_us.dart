import 'package:afghanistan_law_app/src/utils/language_utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'about_menu')),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(
                          context,
                          'about_app_title',
                        ),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'about_app_description'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18.0),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      getTranslated(context, 'about_dev_name'),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      getTranslated(context, 'about_dev_position'),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(LineIcons.facebook),
                        onPressed: () => _launchURL(
                            getTranslated(context, 'about_dev_facebook')),
                      ),
                      IconButton(
                        icon: Icon(LineIcons.instagram),
                        onPressed: () => _launchURL(
                            getTranslated(context, 'about_dev_instagram')),
                      ),
                      IconButton(
                        icon: Icon(LineIcons.github),
                        onPressed: () => _launchURL(
                            getTranslated(context, 'about_dev_github')),
                      ),
                      IconButton(
                        icon: Icon(LineIcons.linkedin),
                        onPressed: () => _launchURL(
                            getTranslated(context, 'about_dev_linked_in')),
                      ),
                      IconButton(
                        icon: Icon(LineIcons.telegram),
                        onPressed: () => _launchURL(
                            getTranslated(context, 'about_dev_telegram')),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
