import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/firebase_options.dart';

import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Topicos
  await FirebaseMessaging.instance.subscribeToTopic("topic");



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FCM Token'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              var client = http.Client();
              try {
              final fcmTokenResp = await FirebaseMessaging.instance.getToken();
              debugPrint('FCM Token: $fcmTokenResp');

              // Salir de la aplicación
              Navigator.of(context).pop();

              // Esperar 3 segundos
              await Future.delayed(Duration(seconds: 3));

              var url = Uri.parse('http://192.168.1.9:3000/sendNotification');
              final response = await client.post(
                url,
                // {"fcmToken": "fcmTokenResp"}
                body: jsonEncode(<String, String>{
                  'fcmToken': fcmTokenResp!,
                }),
                headers: {
                  'Content-Type': 'application/json',
                }
              );
              var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
              debugPrint('Response: ${decodedResponse.toString()}');
              } catch (e) {
              } finally {
                client.close();
              }
            },
            child: const Text('Obtener Token y enviar al servidor')
          ),
        ),
      );
  }
}