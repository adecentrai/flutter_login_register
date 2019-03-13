import 'package:flutter/material.dart';
import 'package:flutter_login_register/data/database_helper.dart';
import 'package:flutter_login_register/models/user.dart';
class HomePage extends StatefulWidget {

  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<HomePage>{
  List<User> users = [new User("vimal","Vimal")];
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new ListView.builder
        (
          itemCount: users.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return singleRow(users[index]);
          }
        )
    );
  }

  @override
  void initState(){
    super.initState();
    var db = new DatabaseHelper();
    db.getAllUser().then((user){
      users = user;
      print(users);
      setState(() {});
    });
  }
  Widget singleRow(User user)
  {
    return new Container(
      padding: EdgeInsets.all(5),
      child: Row(
          children:[
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(user.username,
                style: TextStyle(
                  color:Colors.indigoAccent[500],
                  )
                )
            ],
          )),
          new SubPlusMinus(),
          IconButton(icon: Icon(
            Icons.delete_sweep,
            color: Colors.red[500],
          ), onPressed: (){
            print(user.id.toString() + ' ' + user.username);
            _delete(user);
          }),

      ])
    );
  }
  void _delete(User user)
  {
    var db = new DatabaseHelper();
    db.deleteSingleUser(user.id).then((id){
      print('user has been deleted');
      users.remove(user);
      setState(() {});
    });
  }
}

class SubPlusMinus extends StatefulWidget {

  @override
  State createState() => new SubStatePlusMinus();
}

class SubStatePlusMinus extends State<SubPlusMinus>{
  int quantity;
  Widget build(BuildContext context){
    return new Container(
      padding: EdgeInsets.all(5),
      child:Row(
        children: [
          IconButton(icon: Icon(
          Icons.add,
            color: Colors.red[500],
          ), onPressed: (){
            print("button presseed");
            //_delete(user);
            _plus();
          }),
          SizedBox(
            width: 40,
            height: 40,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2
              ),
            ),
          )
          ,
          IconButton(icon: Icon(
            Icons.remove,
            color: Colors.red[500],
          ), onPressed: (){
            print("button presseed");
            _minus();
            //_delete(user);
          }),
        ]),
    );
  }
  void _plus()
  {
    setState(() { quantity++; });
  }
  void _minus()
  {
    setState(() { quantity--; });
  }
  @override
  void initState(){
    super.initState();
    quantity = 0;
  }
}