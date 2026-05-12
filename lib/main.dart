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
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
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
  final TextEditingController urlController = TextEditingController();

  String selectedMode = 'Video';
  String selectedVideoQuality = '720p';
  String selectedAudioQuality = '320kbps';

  bool isSearching = false;
  bool showOptions = false;

  void processLink() {
    if (urlController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please paste a media URL'),
        ),
      );
      return;
    }

    setState(() {
      isSearching = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isSearching = false;
        showOptions = true;
      });
    });
  }

  void startDownload() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Downloader backend can be connected to permitted media sources.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: const Text(
          'Media Downloader',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Paste Media Link',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: urlController,
                    decoration: InputDecoration(
                      hintText: 'Paste URL here...',
                      prefixIcon: const Icon(Icons.link),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: processLink,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: isSearching
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'ENTER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            if (showOptions)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Download Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMode = 'Video';
                              });
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: selectedMode == 'Video'
                                    ? Colors.red
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  'Download Video',
                                  style: TextStyle(
                                    color: selectedMode == 'Video'
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMode = 'MP3';
                              });
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: selectedMode == 'MP3'
                                    ? Colors.red
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  'Convert to MP3',
                                  style: TextStyle(
                                    color: selectedMode == 'MP3'
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    if (selectedMode == 'Video')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Video Quality',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: selectedVideoQuality,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: '360p',
                                child: Text('360p'),
                              ),
                              DropdownMenuItem(
                                value: '720p',
                                child: Text('720p HD'),
                              ),
                              DropdownMenuItem(
                                value: '1080p',
                                child: Text('1080p Full HD'),
                              ),
                              DropdownMenuItem(
                                value: '4K',
                                child: Text('4K Ultra HD'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedVideoQuality = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    if (selectedMode == 'MP3')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Audio Quality',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: selectedAudioQuality,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: '128kbps',
                                child: Text('128 kbps'),
                              ),
                              DropdownMenuItem(
                                value: '192kbps',
                                child: Text('192 kbps'),
                              ),
                              DropdownMenuItem(
                                value: '320kbps',
                                child: Text('320 kbps High Quality'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedAudioQuality = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: startDownload,
                        icon: const Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'DOWNLOAD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
