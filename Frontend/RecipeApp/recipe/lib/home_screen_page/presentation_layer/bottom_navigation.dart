import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/home_screen_page/application_layer/page_controller.dart';

class CurvedNavigation extends ConsumerWidget {
  const CurvedNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CurvedNavigationBar(
      backgroundColor: Colors.grey.shade50,
      color: const Color(0xff5165EA),
      animationDuration: const Duration(milliseconds: 200),
      buttonBackgroundColor: const Color(0xff4A5AEA),
      onTap: (index) {
        ref.read(pageControllerProvider.notifier).setPage(index);
      },
      items: const <Widget>[
        Icon(
          CupertinoIcons.home,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.search_off_outlined,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          CupertinoIcons.plus,
          size: 30,
          color: Colors.white,
        ),
        // Icon(
        //   Icons.bookmark_outline_rounded,
        //   size: 30,
        //   color: Colors.white,
        // ),
        Icon(
          Icons.person_outline_rounded,
          size: 30,
          color: Colors.white,
        ),
      ],
    );
  }
}
