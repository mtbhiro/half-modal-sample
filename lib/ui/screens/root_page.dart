import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_blueprint/ui/modal_bottom_sheet.dart';

final heightProvider = StateProvider((ref) {
  return 500.0;
});
final minHeightProvider = StateProvider((ref) {
  return 500.0;
});

class RootPage extends HookConsumerWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Root')),
      body: Center(
        child: TextButton(
          onPressed: () {
            _showBottomSheetSample(context, ref);
          },
          child: const Text('modal'),
        ),
      ),
    );
  }

  void _showBottomSheetSample(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return const HalfModalBottomSheet();
        });
    print(result);
  }
}
