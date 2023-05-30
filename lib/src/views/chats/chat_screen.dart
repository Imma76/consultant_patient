// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../../all_providers/all_providers.dart';
import '../../controllers/user_controller.dart';
import '../../models/appointment_model.dart';
import '../../services/chat_service.dart';
import '../../themes/app_theme.dart';

final StreamController<ChatMessageModel> _chatMessagesStreamController =
StreamController<ChatMessageModel>.broadcast();
final Stream<ChatMessageModel> _chatMessagesStream =
    _chatMessagesStreamController.stream;






class ChatMessageModel {
  final String? message;
  final String? sender;
  const ChatMessageModel( {
    this.message, this.sender,

  });

  factory ChatMessageModel.turnSnapshotIntoListRecord(Map data) {
    return ChatMessageModel(
      message: data['message'],
      sender:data['sender'],
    );
  }

  List<Object> get props => [
    message!,
  ];
}

class ChatScreen extends StatefulWidget {

  final AppointmentModel? appointment;
  static const String id = 'chat_screen';

  const ChatScreen({Key? key,this.appointment }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();
  //late Stream messages;
  String? _userInput;
  Stream? snapshotData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   snapshotData= FirebaseMessageService.getChatRooms(userController.patient!.firstName!).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        leading:  Row(
          children: [
            IconButton(icon:Icon(Icons.arrow_back_ios,color: AppTheme.black2,),onPressed: (){
              Navigator.pop(context);

            },),
           ],
        ),
        actions: [
          Row(children: [
            CircleAvatar(radius: 2,backgroundColor: AppTheme.primary,), Gap(8.w), Text(
              'Dr. ${widget.appointment!.consultant!.firstName!}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Gap(20),
            CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.appointment!.consultant!.photoUrl.toString() ,),),
Gap(8),
          ],)

        ],
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseMessageService.getChatRooms(userController.patient!.firstName!),
            builder: (context, snapshot) {

              if(snapshot.hasData) {
                var userInfo = snapshot.data?.docs.toList();
                return SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      MessagesStream(chatRoomId:userInfo![0]['chatroomid']),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,right:8.0,bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.grey,
                            borderRadius: BorderRadius.circular(20)
                            // border: Border(
                            //   top: BorderSide(
                            //     color: AppTheme.primary,
                            //     width: 1.0,
                            //   ),
                            // ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                            //  Icon(Icons.add),
                              Expanded(
                                child: TextField(
                                  controller: _messageTextController,
                                  onChanged: (value) {
                                    _userInput = value;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    hintText: 'Type your message here',
                                    // border: InputBorder.none,
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(backgroundColor: AppTheme
                                    .primary, shape: CircleBorder()),
                                onPressed: () async {
                                  debugPrint(
                                      'Adding a ChatMessageModel with the message $_userInput to the Stream');



                                  ChatMessageModel chatMessageModelRecord =
                                  ChatMessageModel(
                                      message: _userInput, sender: userController
                                      .patient!.firstName);

                                  await FirebaseMessageService
                                      .addConversationMessages(
                                      userInfo![0]['chatroomid'], _userInput);

// await FirebaseMessageModel.sendMessage(message: _userInput!, user: UserSharedPref.getName()!, receiver:widget.username , receiverNo: widget.userPhone);
                                  _chatMessagesStreamController.add(
                                    chatMessageModelRecord,
                                  );
                                  _messageTextController.clear();
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );

              }

              return SizedBox();
            }


          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseMessageService.getAppointment(widget.appointment!.appointmentId!),
              builder: (context, snapshot) {
                if(snapshot.hasData
                ){
                  if(snapshot.data!['sessionEnded'] == true){

                    return SessionEndDialog();

                  }
                }
                return SizedBox();
              }),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final String? chatRoomId;

  const MessagesStream({Key? key, this.chatRoomId}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream:FirebaseMessageService.getConversationMessages(chatRoomId),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return Expanded(
            child: ListView.builder(
              // reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var message = snapshot.data.docs.toList();
                  return UserChatBubble(
                    user: message[index]['sendBy'] == userController.patient!.firstName?true:false,
                    chatMessage:message[index]['message'],
                    time: '${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${message[index]['time'].toDate().hour}:${message[index]['time'].toDate().minute}:${message[index]['time'].toDate().second}"))}',
                  );
                }
            ),
          );
        } else {
          print(snapshot.connectionState);
          return Container();
        }


      },
    );
  }
}

class UserChatBubble extends StatelessWidget {
  final String chatMessage;
  final bool user;
  final String? time;
  const UserChatBubble({
    Key? key,
    required this.chatMessage,
    required this.user,this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: user?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: Column(

            children: [
              Bubble(
                margin: BubbleEdges.only(top: 10),
                nip:user?BubbleNip.rightTop: BubbleNip.leftTop,

                color:user? AppTheme.primary:AppTheme.greyMessageColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chatMessage,
                      style: GoogleFonts.dmSans(
                        fontSize: 14.sp,
                        // fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$time',
                      style: TextStyle(
                        fontSize: 8.sp,
                        // fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}



class SessionEndDialog extends ConsumerWidget {

  const SessionEndDialog({
    Key? key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context,ref) {
    final appointmentController = ref.watch(appointmentProvider);
    return Dialog(
        child: Container(
          height: 120.h,
          width: 382.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .center,
            children: [
              Gap(16.h),
              Text('Session has been ended'
                  , style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight
                          .w400,
                      color:
                      //  AppTheme.red
                      AppTheme.lightBlack
                          .withOpacity(0.6)
                  )),

              Gap(12.h),

              ElevatedButton(onPressed: ()async {
                Navigator.pop(context);
              //  Navigator.pop(context);

              },
                child: Text('Okay',
                  style: GoogleFonts.poppins(
                      color: AppTheme.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight
                          .w700),),
                style: ElevatedButton.styleFrom(
                    primary: AppTheme.primary,
                    minimumSize: Size(
                        154.w, 40.h),fixedSize: Size(
                    154.w, 40.h) ),),


            ],
          ),
          decoration: BoxDecoration(
            color: AppTheme.white,

            borderRadius: BorderRadius.circular(
                10),),

        )
    );
  }
}
