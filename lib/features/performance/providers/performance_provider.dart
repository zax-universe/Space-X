import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/performance_mode.dart';

class PerformanceState {
  final double cpuUsage;
  final double gpuUsage;
  final double ramUsage;
  final double temperature;
  final PerformanceMode mode;
  final bool isOptimizing;

  const PerformanceState({
    this.cpuUsage = 45,
    this.gpuUsage = 52,
    this.ramUsage = 68,
    this.temperature = 38,
    this.mode = PerformanceMode.balanced,
    this.isOptimizing = false,
  });

  PerformanceState copyWith({
    double? cpuUsage,
    double? gpuUsage,
    double? ramUsage,
    double? temperature,
    PerformanceMode? mode,
    bool? isOptimizing,
  }) {
    return PerformanceState(
      cpuUsage: cpuUsage ?? this.cpuUsage,
      gpuUsage: gpuUsage ?? this.gpuUsage,
      ramUsage: ramUsage ?? this.ramUsage,
      temperature: temperature ?? this.temperature,
      mode: mode ?? this.mode,
      isOptimizing: isOptimizing ?? this.isOptimizing,
    );
  }
}

class PerformanceNotifier extends StateNotifier<PerformanceState> {
  Timer? _updateTimer;
  final Random _random = Random();

  PerformanceNotifier() : super(const PerformanceState()) {
    _startSimulation();
  }

  void _startSimulation() {
    _updateTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (state.isOptimizing) return;

      final cpu = _clamp(state.cpuUsage + _random.nextDouble() * 10 - 5);
      final gpu = _clamp(state.gpuUsage + _random.nextDouble() * 10 - 5);
      final ram = _clamp(state.ramUsage + _random.nextDouble() * 6 - 3);
      final temp = 35 + (cpu * 0.3) + _random.nextDouble() * 4 - 2;

      state = state.copyWith(
        cpuUsage: cpu,
        gpuUsage: gpu,
        ramUsage: ram,
        temperature: temp.clamp(30, 80),
      );
    });
  }

  void setMode(PerformanceMode mode) {
    state = state.copyWith(mode: mode);

    // Simulate transition
    state = state.copyWith(isOptimizing: true);
    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        isOptimizing: false,
        cpuUsage: mode.targetCpu + _random.nextDouble() * 10 - 5,
        gpuUsage: mode.targetGpu + _random.nextDouble() * 10 - 5,
        ramUsage: mode.targetRam + _random.nextDouble() * 6 - 3,
      );
    });
  }

  void optimizeNetwork() {
    state = state.copyWith(isOptimizing: true);
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(isOptimizing: false);
    });
  }

  double _clamp(double value) => value.clamp(5, 95);

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }
}

class NetworkState {
  final int ping;
  final int jitter;
  final double loss;
  final bool isOptimizing;

  const NetworkState({
    this.ping = 24,
    this.jitter = 2,
    this.loss = 0.0,
    this.isOptimizing = false,
  });

  NetworkState copyWith({
    int? ping,
    int? jitter,
    double? loss,
    bool? isOptimizing,
  }) {
    return NetworkState(
      ping: ping ?? this.ping,
      jitter: jitter ?? this.jitter,
      loss: loss ?? this.loss,
      isOptimizing: isOptimizing ?? this.isOptimizing,
    );
  }
}

class NetworkNotifier extends StateNotifier<NetworkState> {
  NetworkNotifier() : super(const NetworkState());

  void optimize() {
    state = state.copyWith(isOptimizing: true);
    Future.delayed(const Duration(seconds: 2), () {
      state = const NetworkState(ping: 12, jitter: 1, loss: 0.0, isOptimizing: false);
    });
  }
}

final performanceProvider = StateNotifierProvider<PerformanceNotifier, PerformanceState>((ref) {
  return PerformanceNotifier();
});

final networkProvider = StateNotifierProvider<NetworkNotifier, NetworkState>((ref) {
  return NetworkNotifier();
});
