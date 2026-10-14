{root}: {
  OPENAI_API_KEY = "${root.secrets.openai-api-key}";
  JIRA_API_TOKEN = "${root.secrets.jira-api-token}";
  BITBUCKET_API_TOKEN = "${root.secrets.bitbucket-api-token}";
  PIPER_VOICE_MODEL = "${root.packages.piper-voice}${root.packages.piper-voice.modelPath}";
}
