import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_blueprint/ui/screens/root_page.dart';

final _halfModalContextProvider =
    Provider<BuildContext>((ref) => throw UnimplementedError());

class HalfModalBottomSheet extends HookConsumerWidget {
  const HalfModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = useState(500.0);
    return SafeArea(
      child: AnimatedContainer(
        alignment: Alignment.bottomCenter,
        duration: const Duration(milliseconds: 300),
        height: height.value,
        child: _scaffold(),
      ),
    );
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appbar'),
      ),
      body: const Text('hi'),
    );
  }
}

// class HalfModalBottomSheet extends StatefulWidget {
//   const HalfModalBottomSheet({
//     Key? key,
//     required this.maxSize,
//     required this.builder,
//   }) : super(key: key);

//   final Size maxSize;
//   final double modalHeight;
//   final WidgetBuilder builder;

//   @override
//   _HalfModalBottomSheetState createState() => _HalfModalBottomSheetState();
// }

// class _HalfModalBottomSheetState extends State<HalfModalBottomSheet>
//     with TickerProviderStateMixin {
//   late final _translateController = AnimationController(
//     vsync: this,
//     duration: const Duration(milliseconds: 200),
//   );

//   late final Animation<double> _transitionAnimation =
//       Tween(begin: 0.0, end: widget.modalHeight)
//           .chain(CurveTween(curve: Curves.ease))
//           .animate(_translateController);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         await _translateController.forward(from: 0);
//         return true;
//       },
//       child: AnimatedBuilder(
//         animation: _transitionAnimation,
//         builder: (context, child) => Transform.translate(
//           offset: Offset(0.0, _transitionAnimation.value),
//           child: child,
//         ),
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: SizedBox(
//             width: widget.maxSize.width,
//             height: widget.modalHeight,
//             child: Material(child: widget.builder(context)),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _translateController.dispose();
//     super.dispose();
//   }
// }

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late DraggableScrollableController controller;

  @override
  void initState() {
    super.initState();
    controller = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      // snap: true,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      controller: controller,
      builder: (context, scrollController) {
        return GestureDetector(
          onVerticalDragUpdate: (details) {
            final currentSize = controller.size;
            var deltaSize = controller.pixelsToSize(details.delta.dy);
            final newSize = currentSize - deltaSize;
            controller.jumpTo(newSize);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xffb4b4b4)),
                      height: 4,
                      width: 40,
                    )),
                Expanded(
                  child: _sampleNavigator(scrollController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sampleNavigator(ScrollController controller) {
    return Navigator(
      onGenerateRoute: (context) {
        return MaterialPageRoute(builder: (context) {
          return _listPage(context, controller);
        });
      },
    );
  }

  Widget _listPage(BuildContext context, ScrollController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appbar'),
        actions: [
          IconButton(
            onPressed: () {
              const size = 0.4;
              controller.animateTo(size,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _columnPage(controller);
                  },
                ),
              );
            },
            icon: const Icon(Icons.abc),
          )
        ],
      ),
      body: ListView.builder(
        controller: controller,
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(title: Text('List$index'));
        },
      ),
    );
  }

  Widget _columnPage(ScrollController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appbar'),
        actions: [
          IconButton(
            onPressed: () {
              const size = 0.4;
              controller.animateTo(size,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () {
              const size = 0.9;
              controller.animateTo(size,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            icon: const Icon(Icons.abc),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        child: Column(
          children: const [
            Text('hi'),
            Text('hi'),
            Text('hi'),
            Text('hi'),
            Text('hi'),
            Text('hi'),
            Text('hi'),
          ],
        ),
      ),
    );
  }
}

class MyBottomSheet2 extends HookConsumerWidget {
  const MyBottomSheet2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = ref.watch(heightProvider);
    final _isMovingByTouch = useState(false);
    return GestureDetector(
      child: AnimatedContainer(
        height: height,
        duration: Duration(milliseconds: _isMovingByTouch.value ? 0 : 300),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragUpdate: (details) {
            _isMovingByTouch.value = true;
            final currentHeight = ref.watch(heightProvider);
            final newHeight = currentHeight - details.delta.dy;
            ref.read(heightProvider.notifier).state = newHeight;
          },
          onVerticalDragEnd: (details) {
            _isMovingByTouch.value = false;
            final currentHeight = ref.watch(heightProvider);
            if (currentHeight < 400) {
              Navigator.of(context).pop();
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
                      _halfModalContextProvider.overrideWithValue(context),
                    ],
                    child: _sampleNavigator(context, ref),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sampleNavigator(BuildContext context, WidgetRef ref) {
    return Navigator(
      onGenerateRoute: (context) {
        return MaterialPageRoute(
          builder: (context) {
            return const SelectDateList();
          },
        );
      },
      onPopPage: (route, result) {
        print('onpop');
        return false;
      },
    );
  }
}

class SelectDateList extends HookConsumerWidget {
  const SelectDateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(heightProvider.notifier).state = 600;
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
            final halfModalContext = ref.watch(_halfModalContextProvider);
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
            },
            title: Text('List$index'),
          );
        },
      ),
    );
  }
}

class EventReservationView extends HookConsumerWidget {
  const EventReservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(heightProvider.notifier).state = 420;
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
      body: Container(
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
                  onPressed: () {
                    final halfModalContext =
                        ref.watch(_halfModalContextProvider);
                    Navigator.of(halfModalContext).pop("OK");
                  },
                  child: const Text('予約に進む'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
