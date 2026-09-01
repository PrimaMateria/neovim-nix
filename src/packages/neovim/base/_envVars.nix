{root}: {
  OPENAI_API_KEY = "${root.secrets.openai-api-key}";
  PIPER_VOICE_MODEL = "${root.packages.piper-voice}${root.packages.piper-voice.modelPath}";
}
