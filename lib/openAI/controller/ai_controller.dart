import 'package:assist/openAI/repository/ai_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiControllerProvider = Provider((ref) {
  final aiRepository = ref.watch(aiRepositoryProvider);
  return AIController(aiRepository: aiRepository);
});

class AIController {
  final AIRepository aiRepository;
  AIController({required this.aiRepository});
  void storeSpeech(String speech, String response) {
    aiRepository.storeSpeech(speech, response);
  }
}
