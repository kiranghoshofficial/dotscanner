import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:app_uninstaller/app_uninstaller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

class AppsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Banned Apps In Your Mobile"),
        ),
        body: appslist(),
        backgroundColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      //backgroundColor: Colors.grey,
    );
  }
}

class appslist extends StatefulWidget {
  @override
  _appslist createState() => _appslist();
}
final AudioPlayer audioPlayer=AudioPlayer();

class _appslist extends State<appslist> with WidgetsBindingObserver {
  String uninstallStatus = "";
  bool isEmpty = false;
  DateTime now=new DateTime.now();
  final ScreenshotController _screenshotcontroller=ScreenshotController();
  List<String> list=[];
  AudioCache audioCache=AudioCache(fixedPlayer: audioPlayer);

  bool stopAudio=false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {});
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
        includeAppIcons: true,
      ),
      builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
        if (data.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          List<Application> apps = data.data;
          List<String>packageName = [
            'in.mohalla.sharechat',
            'com.tencent.mm',
            'com.tencent.mobileqq',
            'com.mncgames.play.kikorun',
            'com.getvoo.voodriver',
            'com.nimbuzz',
            'app.buzz.share',
            'com.qzone',
            'com.viber.voip',
            'jp.naver.line.android',
            'com.imo.android.imoim',
            'com.campmobile.snow',
            'com.ss.android.ugc.trill',
            'com.bsb.hike',
            'com.zhiliaoapp.musically',
            'video.like',
            'com.getsamosa',
            'com.lenovo.anyshare.gps',
            'cn.xender',
            'com.dewmobile.kuaiya.play',
            'com.UCMobile.intl',
            'com.uc.browser.en',
            'com.cmcm.live',
            'sg.bigo.live',
            'us.zoom.videomeetings',
            'com.uc.vmate',
            'com.asiainno.uplive',
            'com.cheerfulinc.flipagram',
            'com.intsig.camscanner',
            'com.commsource.beautyplus',
            'com.truecaller',
            'com.pubg.krmobile',
            'com.nono.android',
            'com.hcg.cok.gp',
            'com.mobile.legends',
            'club.fromfactory',
            'com.alibaba.aliexpresshd',
            'com.globalegrow.app.gearbest',
            'com.banggood.client',
            'com.miniinthebox.android',
            'com.tinydeal.android',
            'com.dhgate.buyer',
            'com.lightinthebox.android',
            'com.ericdress.application',
            'com.zaful',
            'com.tlz.tbdress',
            'com.rosegal',
            'com.zzkko',
            'com.romwe',
            'com.tinder',
            'com.trulymadly.android.app',
            'com.ftw_and_co.happn',
            'com.aisle.app',
            'com.coffeemeetsbagel',
            'com.okcupid.okcupid',
            'co.hinge.app',
            'com.azarlive.android',
            'com.bumble.app',
            'com.p1.mobile.putong',
            'de.affinitas.za.co.elitesingles.and',
            'com.taggedapp',
            'com.couchsurfing.mobile.android',
            'com.qihoo.security',
            'com.instagram.android',
            'co.ello.ElloApp',
            'com.snapchat.android',
            'com.eterno',
            'com.newsdog',
            'com.pratilipi.mobile.android',
            'com.luxeva.popxo',
            'com.capcipcup.mommp3',
            'com.yelp.android',
            'com.tumblr',
            'com.reddit.frontpage'
          ];
          List<String>appName = [
            'Kwali',
            'Fast Films',
            'All Tencent gaming Apps',
            'Chinabrands',
            'DX',
            'Modlity',
            'Woo',
            'Badoo',
            'Facebook',
            'Baidu',
            'Heal of Y',
            'Vokal',
            'Hungama',
            'FriendsFeed',
            'Private Blogs'
          ];
          apps.removeWhere((element) {
            return !packageName.contains(element.packageName) &&
                !appName.contains(element.appName);
          });

          if(apps.isEmpty){
            Future.delayed(Duration(seconds: 1),(){
              playMusic("a");
            });
          }
          if(apps.isNotEmpty){
            Future.delayed(Duration(seconds: 1),(){
              playMusic("b");
            });
          }

          return apps.isNotEmpty ? Scrollbar(
              child: ListView.builder(
                  itemCount: apps.length,
                  itemBuilder: (BuildContext context, int position) {
                    Application app = apps[position];
                    if (apps.length == 0) {
                      Future.delayed(Duration(seconds: 0), () {
                        setState(() {
                          isEmpty = true;
                        });
                      });
                    } else if (apps.length > 0) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: app is ApplicationWithIcon
                                ? CircleAvatar(
                              backgroundImage: MemoryImage(app.icon),
                              backgroundColor: Colors.white,
                            )
                                : null,
                            onTap: () async {
                              try {
                                bool isUninstalled =
                                await AppUninstaller.Uninstall(
                                    app.packageName);
                                setState(() {
                                  uninstallStatus = isUninstalled
                                      ? "Successfully Uninstalled!"
                                      : "Cancelled by user";
                                });
                              } on Exception {
                                uninstallStatus = "Some error occurred";
                              }
                            },
                            title:
                            Text('${app.appName} (${app.packageName})'),
                            subtitle: Text('Version: ${app.versionName}\n'
                                'System app: ${app.systemApp}\n'
                                'APK file path: ${app.apkFilePath}\n'
                                'Data dir: ${app.dataDir}\n'
                                'Installed: ${DateTime
                                .fromMillisecondsSinceEpoch(
                                app.installTimeMillis).toString()}\n'
                                'Updated: ${DateTime.fromMillisecondsSinceEpoch(
                                app.updateTimeMillis).toString()}'),
                            trailing: GestureDetector(
                              child: Icon(
                                Icons.delete,
                                size:
                                0.0,
                                color: Colors.redAccent,
                              ),
                              onTap: () async {
                                try {
                                  bool isUninstalled =
                                  await AppUninstaller.Uninstall(
                                      app.packageName);
                                  setState(() {
                                    uninstallStatus = isUninstalled
                                        ? "Successfully Uninstalled!"
                                        : "Cancelled by user";
                                  });
                                } on Exception {
                                  uninstallStatus = "Some error occurred";
                                }

                              },
                            ),
                          ),
                          const Divider(
                            height: 1.0,
                          )
                        ],
                      );
                    }
                    print("else is running");
                    Future.delayed(Duration(seconds: 0), () {
                      setState(() {
                        isEmpty = true;
                      });
                    });
                    return Container();
                  }
              )
          ) : Screenshot(
            controller: _screenshotcontroller,
            child: Container(
              color: Colors.white,
              height: height,
              width: width,
              child: Center(child: Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Scan Date:${now.day}/${now.month}/${now.year}",style: TextStyle(
                          fontSize: 20.0,
                        ),
                        ),
                        SizedBox(height: height*0.03,),
                        Text("Scan Time:${now.hour}:${now.minute}:${now.second}",style: TextStyle(
                          fontSize: 20.0,
                        ),
                        ),
                        SizedBox(height: height*0.07,),
                        Text("Your Phone is Secure", style: TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.07,),
                    MaterialButton(
                      onPressed:() async {
                        Uint8List uint8List;
                        await _screenshotcontroller.capture(delay: Duration(milliseconds: 500)).then((Uint8List image){
                          setState(() {
                            print("image empty=${image.isEmpty}");
                            uint8List=image;
                          });
                        });
                        String tempPath = (await getTemporaryDirectory()).path;
                        File file = File('$tempPath/image.png');
                        list.add(file.path);
                        await file.writeAsBytes(uint8List);
                        await Share.shareFiles(list);
                      },
                      minWidth: 280.0,
                      splashColor: Colors.green[800],
                      color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Text(
                        "SHARE",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ),
          );
        }
      },
    );
  }

  void playMusic(String a) async{
    if(a=="a"){
      await audioCache.loop("music/ok.wav");
    }else{
      await audioCache.loop("music/danger.mp3");
    }
  }
  void stop()async{
    await audioPlayer.stop();
  }

}
