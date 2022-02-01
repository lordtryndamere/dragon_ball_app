
import 'package:flutter/material.dart';

class CustomItemList extends StatelessWidget {
  const CustomItemList({Key? key,required this.name, required this.urlImage, required this.route, required this.description}) : super(key: key);
  final String name;
  final String description;
  final String urlImage;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1,right: 0,left: 0),
      child: Card(
        elevation: 2,
        child: ListTile(
          tileColor: Colors.orange[200],
          style:ListTileStyle.list ,
          leading: CircleAvatar(backgroundImage: NetworkImage(urlImage), maxRadius: 25,),
          title: Text(name.toUpperCase(),style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold ,fontStyle: FontStyle.normal)),
          subtitle:Text(description,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.normal)) ,
          onTap: () => Navigator.pushNamed(context,route),
          trailing: const Image(
            image: AssetImage('assets/icon_ball.png'),
            width: 25,
          ),


        ),
      ),
    );
  }
}