import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:straightup_chat/Widgets/widget.dart';
import 'package:straightup_chat/services/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController searchcontroller = TextEditingController();

  QuerySnapshot searchsanpshot;

  initiateSearch(){
    databaseMethod.getUserByUsername(searchcontroller.text).then((val){
      print(val.toString());
      setState(() {
        searchsanpshot = val;
      });

    });
  }

  // creatChatRoomandStartConversation()
  // {
  //   List<String>
  //   databaseMethod.creatChatRoom()
  // }


  Widget searchList ()
  {
    return searchsanpshot != null ? ListView.builder(
        itemCount: searchsanpshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            username: searchsanpshot.documents[index].data["name"],
            useremail: searchsanpshot.documents[index].data["email"],
          );
          
        }
    )
        : Container();
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white30,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: searchcontroller,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      hintText: "Search Username..",
                      hintStyle: TextStyle(
                        color: Colors.white54
                      ),

                      border: InputBorder.none
                    ),
                  )),
                  GestureDetector(
                    onTap: ()
                    {
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF),
                            ]
                          ),
                          borderRadius: BorderRadius.circular(18)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.search)),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String username;
  final String useremail;
  SearchTile({this.username,this.useremail});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: biggerTextStyle(),),
              Text(useremail,style: biggerTextStyle(),),
            ],
          ),
          Spacer(),
          Container(
             decoration: BoxDecoration(
               color: Colors.blue,
               borderRadius:  BorderRadius.circular(30)
             ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text("Message",style: biggerTextStyle(),),
          )
        ],
      ),

    );
  }
}

