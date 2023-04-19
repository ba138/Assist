import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../feature_box.dart';
import '../../openAi_service.dart';
import '../../pallete.dart';
import '../../utills/nav_bar.dart';
import '../controller/ai_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  FlutterTts flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedUrl;
  final OpenAiService openAiService = OpenAiService();
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: BounceInDown(
          child: const Text(
            'Assist',
            style: TextStyle(fontFamily: 'Cera Pro'),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              child: Container(
                height: 123,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/virtualAssistant.png'),
                  ),
                ),
              ),
            ),
            FadeInRight(
              child: Visibility(
                visible: generatedUrl == null,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible:
                              generatedContent != null && generatedUrl != null,
                          child: Text(
                            ' Me: $lastWords',
                            style: const TextStyle(
                              fontFamily: 'Cera Pro',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          generatedContent == null
                              ? 'How are you Basit, How may I Assist you!'
                              : 'Assistance : ${generatedContent!}',
                          style: TextStyle(
                              fontFamily: 'Cera Pro',
                              fontSize: generatedContent == null ? 24 : 18,
                              color: Pallete.mainFontColor),
                        ),
                      ],
                    )),
              ),
            ),
            if (generatedUrl != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Me: $lastWords',
                      style: const TextStyle(
                        fontFamily: 'Cera Pro',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        generatedUrl!,
                      ),
                    ),
                  ],
                ),
              ),
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedUrl == null,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                    left: 22,
                  ),
                  child: const Text(
                    'Here are some features',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 20,
                      color: Pallete.mainFontColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedUrl == null,
              child: Column(
                children: const [
                  FeatureBox(
                    header: "ChatGPT",
                    color: Pallete.borderColor,
                    dis:
                        'A smarter way to stay origanized and informed with ChatGPT',
                  ),
                  FeatureBox(
                    header: "Dall-E",
                    color: Pallete.borderColor,
                    dis:
                        'Get inspired and stay creative with personal assistant powered by Dall-e',
                  ),
                  FeatureBox(
                    header: "Smart Voice Assiitant",
                    color: Pallete.borderColor,
                    dis:
                        'Get inspired and stay creative with personal assistant powered by Dall-e',
                  ),
                  FeatureBox(
                    header: "Store History",
                    color: Pallete.borderColor,
                    dis:
                        'Smart voice assistant Store history of you search and command',
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.thirdSuggestionBoxColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAiService.isArtPromptAPI(lastWords);

            if (speech.contains('https')) {
              generatedUrl = speech;
              generatedContent = null;

              setState(() {});
            } else {
              generatedUrl = null;
              generatedContent = speech;
              setState(() {});
              await systemSpeak(speech);
            }

            print(lastWords);
            print(speech);
            await stopListening();
            ref.watch(aiControllerProvider).storeSpeech(lastWords, speech);
          } else {
            initSpeechToText();
          }
        },
        child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
      ),
    );
  }
}
