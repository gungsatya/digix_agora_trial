import 'dart:async';
import 'package:digix_agora_trial/video_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  runApp(MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: MyApp(
        sendMessage: showMessage,
      )));
}

class MyApp extends StatefulWidget {
  final Function(String) sendMessage;

  const MyApp({super.key, required this.sendMessage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  String appId = dotenv.env['AGORA_APP_ID'] ?? '';
  // String channelName = '';
  // String token = '';

  TextEditingController channelNameController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preparation'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: channelNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter channel name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xffF1F0F5),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    labelText: 'Channel Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: tokenController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the token';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xffF1F0F5),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(),
                    ),
                    labelText: 'Token',
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String channelName = channelNameController.text;
                      String token = tokenController.text;
                      // print("appId : $appId");
                      // print("channelName : $channelName");
                      // print("token : $token");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => VideoCallScreen(
                                appId: appId,
                                channelName: channelName,
                                token: token,
                                showMessage: widget.sendMessage)),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 15)),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
