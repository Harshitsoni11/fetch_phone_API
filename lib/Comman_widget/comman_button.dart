import 'package:flutter/material.dart';

class
CommanButton extends StatefulWidget {

  IconData icon;
  String title;
   CommanButton({required this.icon,required this.title});

  @override
  State<CommanButton> createState() => _CommanButtonState();
}

class _CommanButtonState extends State<CommanButton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 110,
      width: 110,
      child: Card(
          color: Colors.white,
          elevation: 13.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 40,),
                SizedBox(height: 5,),
                Text(widget.title)
              ],
            ),
          )
      ),
    );
  }
}

