{pkgs}:
# Inference only. The train/http/alignment extras drag in torch, lightning,
# librosa and triton (~2.8 GiB closure) and are unused by the `piper` CLI.
pkgs.piper-tts.override {
  withTrain = false;
  withHTTP = false;
  withAlignment = false;
}
