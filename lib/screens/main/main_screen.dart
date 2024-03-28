import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("Main"),
      ),
      drawer: const Drawer(),
      child: const Placeholder(),
    );
  }
}
