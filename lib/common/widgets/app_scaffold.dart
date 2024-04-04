import 'package:daelim_univ/common/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {super.key,
      this.floatingActionButton,
      this.appBar,
      this.bottomNavigationBar,
      required this.child});

  final FloatingActionButton? floatingActionButton;
  final Widget child;
  final BottomNavigationBar? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionButton,
        appBar: appBar,
        drawer: const AppDrawer(),
        body: SafeArea(
          child: child,
        ),
        bottomNavigationBar: bottomNavigationBar);
  }
}

// curl -X GET "https://121.140.73.79:18443/functions/v1/hello"