// ignore_for_file: invalid_use_of_protected_member, library_prefixes, constant_identifier_names, non_constant_identifier_names, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:url_launcher/url_launcher.dart';

class MensagemText extends StatelessWidget {
  const MensagemText({
    Key? key,
    required this.constraints,
    required this.textMessage,
  }) : super(key: key);

  final dynamic constraints;
  final String textMessage;

  @override
  Widget build(BuildContext context) {
    findUrl(textMessage).forEach(
      (element) {
        MetadataFetch.extract(element).then(
          (value) {
            if (value == null) {
              return;
            }
            showDialog(
              context: context,
              builder: (e) => AlertDialog(
                content: Container(
                  child: Text(
                    value.title ?? '',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
          padding: const EdgeInsets.only(top: 4.0),
          child: Wrap(
            children: [
              SelectableLinkify(
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
                text: textMessage,
                style: const TextStyle(color: Colors.white),
                linkStyle: TextStyle(color: Colors.blue.shade200),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<String> findUrl(String text) {
  RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(text);

  List<String> urls = [];
  for (var match in matches) {
    urls.add(text.substring(match.start, match.end));
  }
  return urls;
}
