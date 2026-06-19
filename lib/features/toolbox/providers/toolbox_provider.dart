import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolboxState {
  final bool dndEnabled;
  final bool blockCallsEnabled;
  final bool screenshotEnabled;
  final bool screenRecordEnabled;
  final bool voiceChangerEnabled;
  final bool brightnessLockEnabled;
  final bool floatingToolboxEnabled;

  const ToolboxState({
    this.dndEnabled = false,
    this.blockCallsEnabled = false,
    this.screenshotEnabled = false,
    this.screenRecordEnabled = false,
    this.voiceChangerEnabled = false,
    this.brightnessLockEnabled = false,
    this.floatingToolboxEnabled = true,
  });

  ToolboxState copyWith({
    bool? dndEnabled,
    bool? blockCallsEnabled,
    bool? screenshotEnabled,
    bool? screenRecordEnabled,
    bool? voiceChangerEnabled,
    bool? brightnessLockEnabled,
    bool? floatingToolboxEnabled,
  }) {
    return ToolboxState(
      dndEnabled: dndEnabled ?? this.dndEnabled,
      blockCallsEnabled: blockCallsEnabled ?? this.blockCallsEnabled,
      screenshotEnabled: screenshotEnabled ?? this.screenshotEnabled,
      screenRecordEnabled: screenRecordEnabled ?? this.screenRecordEnabled,
      voiceChangerEnabled: voiceChangerEnabled ?? this.voiceChangerEnabled,
      brightnessLockEnabled: brightnessLockEnabled ?? this.brightnessLockEnabled,
      floatingToolboxEnabled: floatingToolboxEnabled ?? this.floatingToolboxEnabled,
    );
  }
}

class ToolboxNotifier extends StateNotifier<ToolboxState> {
  ToolboxNotifier() : super(const ToolboxState());

  void toggleDnd() => state = state.copyWith(dndEnabled: !state.dndEnabled);
  void toggleBlockCalls() => state = state.copyWith(blockCallsEnabled: !state.blockCallsEnabled);
  void toggleScreenshot() => state = state.copyWith(screenshotEnabled: !state.screenshotEnabled);
  void toggleScreenRecord() => state = state.copyWith(screenRecordEnabled: !state.screenRecordEnabled);
  void toggleVoiceChanger() => state = state.copyWith(voiceChangerEnabled: !state.voiceChangerEnabled);
  void toggleBrightnessLock() => state = state.copyWith(brightnessLockEnabled: !state.brightnessLockEnabled);
  void toggleFloatingToolbox() => state = state.copyWith(floatingToolboxEnabled: !state.floatingToolboxEnabled);
}

final toolboxProvider = StateNotifierProvider<ToolboxNotifier, ToolboxState>((ref) {
  return ToolboxNotifier();
});
