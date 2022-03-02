class PadlockState {
  bool isLocked;

  PadlockState({
    this.isLocked = true,
  });

  bool get isUnlocked => !isLocked;

  void lock() => isLocked = true;

  void unlock() => isLocked = false;
}
