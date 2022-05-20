import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_blueprint/ui/modal_bottom_sheet.dart';
import 'package:my_flutter_blueprint/ui/screens/root_page.dart';

class EventReservationInputProfileSheet extends HookConsumerWidget {
  const EventReservationInputProfileSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(milliseconds: 150));
        ref.read(heightProvider.notifier).state = 580;
        ref.read(minHeightProvider.notifier).state = 580;
      });
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '予約者情報入力',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    '予約者情報',
                    style: TextStyle(
                      color: Color(0xff0E419b),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '編集する',
                      style: TextStyle(
                        color: Color(0xff1C80E7),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(7),
                },
                children: [
                  _tableRow('お名前', '―'),
                  _paddingRow(),
                  _tableRow('高校名', '―'),
                  _paddingRow(),
                  _tableRow('学年', '―'),
                  _paddingRow(),
                  _tableRow('性別', '―'),
                  _paddingRow(),
                  _tableRow('生年月日', '―'),
                  _paddingRow(),
                  _tableRow('電話番号', '―'),
                  _paddingRow(),
                  _tableRow('メール\nアドレス', '―'),
                ],
              ),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '利用規約',
                            style: const TextStyle(
                              color: Color(0xff1C80E7),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('didtap 利用規約');
                              },
                          ),
                          const TextSpan(
                            text: '・',
                            style: TextStyle(
                              color: Color(0xff1C80E7),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: 'プライバシーポリシー',
                            style: const TextStyle(
                              color: Color(0xff1C80E7),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('didtap プラポリ');
                              },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    final halfModalContext =
                        ref.watch(halfModalContextProvider);
                    Navigator.of(halfModalContext).pop("OK");
                  },
                  child: const Text('上記に同意して予約する'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _tableRow(String label, String content) {
    return TableRow(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xff808D96),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          content,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xff808D96),
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  TableRow _paddingRow() {
    return const TableRow(children: [
      SizedBox(height: 8),
      SizedBox(height: 8),
    ]);
  }
}
