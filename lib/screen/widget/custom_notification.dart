import 'package:flutter/material.dart';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/styles.dart';
//import 'package:google_fonts/google_fonts.dart';

class CustomNotificationWidget extends StatefulWidget {
  final String title;
  final String body;
  final void Function(BuildContext) onTap;

  const CustomNotificationWidget({
    Key key,
    @required this.title,
    @required this.body,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomNotificationWidgetState createState() =>
      _CustomNotificationWidgetState();
}

class _CustomNotificationWidgetState extends State<CustomNotificationWidget> {
  @override
  void initState() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.receivedMessage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => widget.onTap(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.primaryColorDark,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidCommentAlt,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        color: AppStyles.primaryColorWhite, fontSize: 12),

                    /*style: GoogleFonts.acme(
                        textStyle: theme.textTheme.subtitle1
                            .copyWith(color: Colors.white)),*/
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.body,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: AppStyles.primaryColorWhite, fontSize: 12),
                /*style: GoogleFonts.basic(
                    textStyle: theme.textTheme.subtitle1
                        .copyWith(color: Colors.white)),*/
              ),
            )
          ],
        ),
      ),
    );
  }
}
