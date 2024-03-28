import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {super.key,
      this.floatingActionButton,
      this.appBar,
      this.drawer,
      this.bottomNavigationBar,
      required this.child});

  final FloatingActionButton? floatingActionButton;
  final Widget child;
  final Widget? drawer;
  final BottomNavigationBar? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionButton,
        appBar: appBar,
        drawer: drawer,
        body: SafeArea(
          child: child,
        ),
        bottomNavigationBar: bottomNavigationBar);
  }
}
