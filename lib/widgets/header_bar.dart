import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderBar({
    super.key,
    required this.headerTitle,
  });

  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          headerTitle,
        ),
        // leading: GestureDetector(
        //   onTap: () {},
        //   child: Container(
        //     margin: const EdgeInsets.all(10.0),
        //     alignment: Alignment.center,
        //     child: const Text('back'),
        //   ),
        // ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              alignment: Alignment.center,
              child: const MenuIconButton(),
            ),
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(66);
}
