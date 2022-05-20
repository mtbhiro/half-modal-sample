import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_blueprint/ui/screens/root_page.dart';
import 'package:my_flutter_blueprint/ui/screens/select_date_list.dart';

final halfModalContextProvider =
    Provider<BuildContext>((ref) => throw UnimplementedError());

class HalfModalBottomSheet extends HookConsumerWidget {
  const HalfModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = ref.watch(heightProvider);
    final _isMovingByTouch = useState(false);
    return GestureDetector(
      child: AnimatedContainer(
        height: height,
        duration: Duration(milliseconds: _isMovingByTouch.value ? 0 : 250),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragUpdate: (details) {
            _isMovingByTouch.value = true;
            final currentHeight = ref.watch(heightProvider);
            final newHeight = currentHeight - details.delta.dy;
            if (newHeight > 750) {
              ref.read(heightProvider.notifier).state = 750;
            } else {
              ref.read(heightProvider.notifier).state = newHeight;
            }
          },
          onVerticalDragEnd: (details) {
            _isMovingByTouch.value = false;
            final currentHeight = ref.watch(heightProvider);
            final minHeight = ref.watch(minHeightProvider);
            if (currentHeight < minHeight) {
              Navigator.of(context).pop();
            }
            if (currentHeight > minHeight + (750 - minHeight) / 2) {
              ref.read(heightProvider.notifier).state = 750;
            } else {
              ref.read(heightProvider.notifier).state = minHeight;
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xffb4b4b4)),
                        height: 4,
                        width: 40,
                      )),
                ),
                Expanded(
                  child: ProviderScope(
                    overrides: [
                      halfModalContextProvider.overrideWithValue(context),
                    ],
                    child: Navigator(
                      onGenerateRoute: (context) {
                        return MaterialPageRoute(
                          builder: (context) {
                            return const SelectDateList();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
