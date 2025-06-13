import 'package:url_launcher/url_launcher.dart';

class UrlOpener {
  static Future<void> openUrlInBrowser(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
