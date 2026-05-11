import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController urlController = TextEditingController();

  String selectedType = 'video';
  String selectedQuality = '720p';

  final List<String> videoQualities = [
    '144p',
    '360p',
    '720p',
    '1080p'
  ];

  final List<String> audioQualities = [
    '128kbps',
    '192kbps',
    '320kbps'
  ];

  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Downloader'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                hintText: 'Paste media link here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedType = 'video';
                        selectedQuality = '720p';
                      });
                    },
                    child: const Text('Download Video'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedType = 'audio';
                        selectedQuality = '128kbps';
                      });
                    },
                    child: const Text('Convert to MP3'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedQuality,
              items: (selectedType == 'video'
                      ? videoQualities
                      : audioQualities)
                  .map((quality) {
                return DropdownMenuItem(
                  value: quality,
                  child: Text(quality),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedQuality = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Quality',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  startDownload();
                },
                child: const Text(
                  'Download',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),

            LinearProgressIndicator(
              value: progress,
            ),
          ],
        ),
      ),
    );
  }

  void startDownload() {
    final url = urlController.text.trim();

    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid URL'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Starting $selectedType download in $selectedQuality quality',
        ),
      ),
    );

    setState(() {
      progress = 0.5;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        progress = 1.0;
      });
    });
  }
}
