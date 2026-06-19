import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BoostState { idle, optimizing, optimized }

class HomeState {
  final BoostState boostState;
  final double boostProgress;

  const HomeState({
    this.boostState = BoostState.idle,
    this.boostProgress = 0,
  });

  HomeState copyWith({
    BoostState? boostState,
    double? boostProgress,
  }) {
    return HomeState(
      boostState: boostState ?? this.boostState,
      boostProgress: boostProgress ?? this.boostProgress,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  Timer? _optimizationTimer;
  Timer? _resetTimer;

  HomeNotifier() : super(const HomeState());

  void startBoost() {
    if (state.boostState != BoostState.idle) return;

    state = state.copyWith(boostState: BoostState.optimizing, boostProgress: 0);

    // Simulate optimization progress
    var progress = 0.0;
    _optimizationTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      progress += 2;
      if (progress >= 100) {
        timer.cancel();
        state = state.copyWith(boostState: BoostState.optimized, boostProgress: 100);
        
        // Auto-reset after 3 seconds
        _resetTimer = Timer(const Duration(seconds: 3), () {
          state = const HomeState();
        });
      } else {
        state = state.copyWith(boostProgress: progress);
      }
    });
  }

  @override
  void dispose() {
    _optimizationTimer?.cancel();
    _resetTimer?.cancel();
    super.dispose();
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
