import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkLauncher {
  static Future<void> openUrl(
    BuildContext context,
    String url,
  ) async {
    final uri = Uri.parse(url);

    try {
      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        _showError(
          context,
          'Could not open the link.',
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showError(
          context,
          'Unable to open the link.',
        );
      }
    }
  }

  static Future<void> sendEmail(
    BuildContext context,
  ) async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'ashishgaikwad9561@gmail.com',
      queryParameters: {
        'subject': 'Software Development Opportunity',
      },
    );

    try {
      final launched = await launchUrl(uri);

      if (!launched && context.mounted) {
        _showError(
          context,
          'No email application found.',
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showError(
          context,
          'Unable to open email application.',
        );
      }
    }
  }

  static void _showError(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}