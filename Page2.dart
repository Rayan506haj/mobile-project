import 'package:flutter/material.dart';
import 'User.dart';
import 'skinType.dart';
class Page2 extends StatefulWidget {
  final User user;
  const Page2({Key? key, required this.user}) : super(key: key);
  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Skin skin = skins.first; // set the first car to be displayed
  void updateSkin(Skin skin) {
    setState(() {
      this.skin = skin;
    });
  }
  @override
  Widget build(BuildContext context) {
    final newUser = widget.user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Skin_care Application",
            style:TextStyle(
                color: Colors.white70,
                fontSize: 30
            )
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Center(child: Column(children: [

          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/dry.jpg',height:250,width:500),
            Image.asset('assets/acne.jpg',height:250,width:500),
            ]),

        const SizedBox(height: 10),
        Text('Welcome ${newUser.name}!',
            style: const TextStyle( fontSize:29,  color:Colors.deepPurpleAccent),textAlign: TextAlign.center),
        const SizedBox(height: 20.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset ('assets/dry.jpg',height:250,width:500),
              Image.asset ('assets/acne.jpg',height:250,width:500),
            ]),
        const Text('Select Your Skin Type', style: TextStyle(fontSize: 25.0)), const SizedBox(height: 10.0),
        MyDropdownMenuWidget(updateSkin: updateSkin), const SizedBox(height: 10.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Acne', style: TextStyle(fontSize: 18.0)),
              Checkbox(value: skin.acne, onChanged: (bool? value) {
                setState(() {
                  skin.acne = value as bool;
                });
              }),
              SizedBox(width: 20.0),
              const Text('Allergy', style: TextStyle(fontSize: 18.0)),
              Checkbox(value: skin.allergy, onChanged: (bool? value) {
                setState(() {
                  skin.allergy = value as bool;
                });
              })

            ]
        ),

      ]),
      ),
    );
  }

}