import 'package:flutter/material.dart';
import 'package:streamer/components/text.dart';

import '../../utils/styles.dart';

class GenderWidget extends StatefulWidget {
  final ValueChanged<String> onSelect;

  const GenderWidget({
    Key key,
    this.onSelect,
  }) : super(key: key);

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  String gender = "ชาย";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final g in ["ชาย", "หญิง"])
          Flexible(
            child: RadioListTile<String>(
              title: AppText(
                g,
                color: AppStyles.primaryColorTextField,
              ),
              value: g,
              groupValue: gender,
              onChanged: onSelect,
              activeColor: AppStyles.primaryColorLight,
            ),
          ),
      ],
    );
  }

  void onSelect(String v) {
    gender = v;
    widget.onSelect(v);
    setState(() {});
  }
}
