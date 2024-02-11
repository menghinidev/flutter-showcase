class FlutterShowcaseEnv {
  static const sentryApiKey = String.fromEnvironment('SENTRY_DSN');
  static const env = String.fromEnvironment('ENV', defaultValue: 'Dev');
}
