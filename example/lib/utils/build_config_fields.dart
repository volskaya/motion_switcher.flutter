part of "build_config_data.dart";

@JsonEnum(valueField: "value")
enum BuildConfigLoggerLevel {
  all("all"),
  trace("trace"),
  debug("debug"),
  info("info"),
  warning("warning"),
  error("error"),
  fatal("fatal"),
  off("off");

  const BuildConfigLoggerLevel(this.value);
  final String value;

  Level getServiceLevel() => switch (this) {
        BuildConfigLoggerLevel.all => Level.all,
        BuildConfigLoggerLevel.trace => Level.trace,
        BuildConfigLoggerLevel.debug => Level.debug,
        BuildConfigLoggerLevel.info => Level.all,
        BuildConfigLoggerLevel.warning => Level.warning,
        BuildConfigLoggerLevel.error => Level.error,
        BuildConfigLoggerLevel.fatal => Level.fatal,
        BuildConfigLoggerLevel.off => Level.off,
      };
}
