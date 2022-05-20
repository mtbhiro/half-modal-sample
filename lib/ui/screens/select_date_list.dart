import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_blueprint/ui/modal_bottom_sheet.dart';
import 'package:my_flutter_blueprint/ui/screens/root_page.dart';

class SelectDateList extends HookConsumerWidget {
  const SelectDateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(heightProvider.notifier).state = 600;
        ref.read(minHeightProvider.notifier).state = 600;
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '日付/時間選択',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            final halfModalContext = ref.watch(halfModalContextProvider);
            Navigator.of(halfModalContext).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              final _ = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const EventReservationView();
                  },
                ),
              );
              ref.read(heightProvider.notifier).state = 600;
              ref.read(minHeightProvider.notifier).state = 600;
            },
            title: Text('List$index'),
          );
        },
      ),
    );
  }
}
