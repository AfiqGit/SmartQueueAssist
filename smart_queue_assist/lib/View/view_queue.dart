import 'package:flutter/material.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:provider/provider.dart';
import 'package:smart_queue_assist/Animations/custom_clipper.dart';
import 'package:smart_queue_assist/Controller/view_queue_controller.dart';
import 'package:smart_queue_assist/Model/User.dart';

class ViewQueue extends StatefulWidget {
  //const ViewQueue({ Key? key }) : super(key: key);

  @override
  _ViewQueueState createState() => _ViewQueueState();
}

class _ViewQueueState extends State<ViewQueue> {
  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        ClipShadow(
            clipper: CustomAppBar(),
            boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 15.0,
                    color: Color.fromRGBO(196, 196, 196, 1),
                  )
                ],
            child: Container(
              height: MediaQuery.of(context).size.height*.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFde6262),
                    Color(0xFFffb88c),
                  ]
                ),
              )
            )  
          ),
         
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'View Queue',
              style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 15.0),
                        width: MediaQuery.of(context).size.width*0.8,
                         decoration: BoxDecoration(
                          color:  Color(0xFFe17272),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: new Offset(0.0, 5.0),
                              blurRadius: 6.0,            
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ViewQueueForUserController(value: 1, userId: userSession.userId),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 15.0),
                        height: 400,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(
                           color:  Color(0xFFe6a67e),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                          new BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: new Offset(0.0, 5.0),
                            blurRadius: 6.0,            
                          )
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ViewQueueForUserController(value: 2, userId: userSession.userId),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0, right: 20.0, bottom: 15.0),
                        height: 400,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(
                          color:  Color(0xFFffbf98),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                          new BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: new Offset(0.0, 5.0),
                            blurRadius: 6.0,            
                          )
                        ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ViewQueueForUserController(value: 3, userId: userSession.userId),
                        ),
                      ),
                    ],
                  ),
                  ] 
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                   gradient: LinearGradient(
                    colors: [
                      Color(0xFFde6262),
                      Color(0xFFffb88c),
                    ]
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: new Offset(0.0, 5.0),
                      blurRadius: 6.0,            
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right:10.0),
                  child: ViewQueueForUserController(value: 4, userId: userSession.userId),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFde6262),
                      Color(0xFFffb88c),
                    ]
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: new Offset(0.0, 5.0),
                      blurRadius: 6.0,            
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right:10.0),
                  child: ViewQueueForUserController(value: 5,  userId: userSession.userId),
                ),
              ),
            ],
          ),
      ),
      ],
    );
  }
}

// class ViewQueuePage extends StatefulWidget {
//   //const ViewQueuePage({ Key? key }) : super(key: key);

//   @override
//   _ViewQueuePageState createState() => _ViewQueuePageState();
// }

// class _ViewQueuePageState extends State<ViewQueuePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }