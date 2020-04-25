import 'package:flutter/cupertino.dart';

class HomeIOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: CupertinoButton(
        child: Text("Apretame!!!", style: TextStyle(color: CupertinoColors.destructiveRed),),
      ),
    );
  }
}
