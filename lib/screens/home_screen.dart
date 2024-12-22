import 'package:flutter/material.dart';
import 'package:dart_mpd/dart_mpd.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String songTitle = "";
  final client = MpdClient(
    connectionDetails: MpdConnectionDetails.resolve(),
  );

  Future<void> onMpdStateChange(MpdClient client) async {
    while (true) {
      MpdSong? song = await client.currentsong();
      List<String>? title = song?.title;
      if (title != null && songTitle != title[0]) {
        songTitle = title[0];
        setState(() {});
      }
      client.idle();
    }
  }

  @override
  void initState() {
    onMpdStateChange(client);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(songTitle),
      ),
    );
  }
}
