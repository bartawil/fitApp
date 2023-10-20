import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyMenuButton extends StatelessWidget {
  String title;
  String icon;
  VoidCallback? onTap;
  Color? backgroundColor;
  Color? fontColor;
  Color? iconColor;

  MyMenuButton({
    Key? key, 
    required this.title,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.fontColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        width: 156,
        height: 156, // set height to the same value as width
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(-5, 10), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(iconColor ?? Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                child: Image.asset(icon, width: 125, height: 125),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: fontColor ?? Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}