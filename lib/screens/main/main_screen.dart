import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/localization/app_string.dart';
import 'package:daelim_univ/screens/main/widgets/pick_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(AppString.home.tr),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(tabs: [
              Tab(
                text: "Pick Card",
              ),
              Tab(
                text: "Unknown",
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                PickCard(),
                const Placeholder(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
