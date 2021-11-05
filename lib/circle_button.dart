import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Icon icon;
  final Function press;

  const CircleButton(this.icon, this.press);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
        onPressed: () {},
        child: IconButton(
          onPressed: press(),
          icon: icon,
        ));
  }
}

/*
Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
            color: Color(0xFF49789E).withOpacity(0.5)
      ),
      child: Center(
        child: IconButton(onPressed: press(), icon: icon,
      ),

      ),
    )
 */
