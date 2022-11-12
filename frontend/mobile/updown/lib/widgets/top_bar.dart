import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key, required this.screenHeight});
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      title: Container(
        color: Theme.of(context).cardColor,
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          semanticsLabel: 'Logo',
        ),
      ),
      toolbarHeight: screenHeight * 0.166,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(screenHeight * 0.166); //appBar height
}
