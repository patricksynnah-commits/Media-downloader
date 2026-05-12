import 'package:flutter/material.dart';

void main() {
  runApp(const MediaDownloaderApp());
}

class MediaDownloaderApp extends StatelessWidget {
  const MediaDownloaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController urlController =
      TextEditingController();

  String downloadType = "Video";
  String quality = "720p";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Downloader"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: urlController,

              decoration: const InputDecoration(
                labelText: "Paste YouTube Link",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: downloadType,

              items: const [
                DropdownMenuItem(
                  value: "Video",
                  child: Text("Download Video"),
                ),

                DropdownMenuItem(
                  value: "MP3",
                  child: Text("Convert to MP3"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  downloadType = value!;
                });
              },

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: quality,

              items: const [
                DropdownMenuItem(
                  value: "360p",
                  child: Text("360p"),
                ),

                DropdownMenuItem(
                  value: "720p",
                  child: Text("720p"),
                ),

                DropdownMenuItem(
                  value: "1080p",
                  child: Text("1080p"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  quality = value!;
                });
              },

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                onPressed: () {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Download feature will be connected later",
                      ),
                    ),
                  );
                },

                child: const Text(
                  "Download",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
