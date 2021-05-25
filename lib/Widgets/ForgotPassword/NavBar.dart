import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final nombreCompleto;
  const NavBar({
    Key key,
    this.nombreCompleto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(this.nombreCompleto),
          SizedBox(
            width: 10,
          ),
          Spacer(),
          Row(
            children: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  animationDuration: Duration(milliseconds: 800),
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Home',
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
