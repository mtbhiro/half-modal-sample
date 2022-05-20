import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_blueprint/ui/screens/event_reservation_input_profile_sheet.dart';
import 'package:my_flutter_blueprint/ui/screens/root_page.dart';

class EventReservationView extends HookConsumerWidget {
  const EventReservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(milliseconds: 150));
        ref.read(heightProvider.notifier).state = 420;
        ref.read(minHeightProvider.notifier).state = 420;
      });
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'イベント予約',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: '8/21',
                                  style: TextStyle(
                                    fontSize: 29,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff24243F),
                                  ),
                                ),
                                TextSpan(
                                  text: '土',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff24243F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '9:00 - 11:00',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff24243F),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '【高校2年生向け】調理の基礎を学べる実習調理の基礎を学べる実習体験!',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff808D96),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.house, size: 88),
                  ],
                ),
                const Text(
                  'KAMOME調理師専門学校',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff808D96),
                  ),
                ),
                const Text(
                  '調理師科',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff808D96),
                  ),
                ),
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () async {
                      final _ = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const EventReservationInputProfileSheet();
                          },
                        ),
                      );
                      ref.read(heightProvider.notifier).state = 420;
                      ref.read(minHeightProvider.notifier).state = 420;
                    },
                    child: const Text('予約に進む'),
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
