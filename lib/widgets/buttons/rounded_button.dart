import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {@required this.text,
      this.color,
      @required this.onPressed,
      this.width = 100.0,
      this.isAsync = false});
  final String text;
  final Color color;
  final Function onPressed;
  final double width;
  final bool isAsync;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          width: width,
          child: Center(
              child: isAsync
                  ? const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(),
                    )
                  : Text(text, style: Theme.of(context).textTheme.headline6)),
        ),
      ),
    );
  }
}
