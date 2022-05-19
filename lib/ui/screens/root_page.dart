import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_blueprint/ui/modal_bottom_sheet.dart';

final heightProvider = StateProvider((ref) {
  return 500.0;
});
final isMovingByTouchProvider = StateProvider((ref) {
  return false;
});

class RootPage extends HookConsumerWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    return Scaffold(
      appBar: AppBar(title: const Text('Root')),
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(heightProvider.notifier).state = 500;
            _showBottomSheetSample(context, ref);
            // _showDialogSample(context);
            // showBarModalBottomSheet(
            //     useRootNavigator: true,
            //     enableDrag: true,
            //     context: context,
            //     builder: (context) {
            //       return _scaffold();
            //     });
          },
          child: const Text('modal'),
        ),
      ),
    );
  }

  void _showBottomSheetSample(BuildContext context, WidgetRef ref) async {
    final result = await showModalBottomSheet(
        context: context,
        // constraints: BoxConstraints(maxHeight: height),
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          // return const MyBottomSheet();
          return const MyBottomSheet2();
        });
    print(result);
  }

  void _showDialogSample(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => LayoutBuilder(
        builder: (context, constraint) => const HalfModalBottomSheet(),
      ),
    );
  }

  void _showGeneralDialogSample(BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: const Text('Hello!!'),
                content: const Text('How are you?'),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container(child: const Text('hi'));
        });
  }
}
