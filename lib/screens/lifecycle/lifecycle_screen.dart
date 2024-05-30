import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/localization/app_string.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class LifecycleScreen extends StatefulWidget {
  const LifecycleScreen({super.key});

  @override
  State<LifecycleScreen> createState() => _LifecycleScreenState();
}

class _LifecycleScreenState extends State<LifecycleScreen> {
  late final AppLifecycleListener _listener;
  late AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();

    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onShow: () => Log.green('show'),
      onResume: () => Log.green('resume'),
      onHide: () => Log.green('hide'),
      onInactive: () => Log.green('inactive'),
      onPause: () => Log.green('pause'),
      onDetach: () => Log.green('detach'),
      onRestart: () => Log.green('restart'),
      // This fires for each state change. Callbacks above fire only for
      // specific state transitions.
      //onStateChange: _handleStateChange,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _listener.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: Text(AppString.lifecycle.tr),
        ),
        child: Center(child: Text(_state.toString())));
  }
}
