/// Returned when the user does an [Action].
class ActionResult<T> {
  /// The result state.
  final ActionResultState state;

  /// The result object.
  final T? object;

  /// Creates a new [ActionResult] instance.
  const ActionResult({
    required this.state,
    this.object,
  });

  /// Creates a new [ActionResult] instance with the [state] being [ActionResultState.success].
  const ActionResult.success({
    T? object,
  }) : this(
          state: ActionResultState.success,
          object: object,
        );

  /// Creates a new [ActionResult] instance with the [state] being [ActionResultState.needAction].
  const ActionResult.needAction({
    T? object,
  }) : this(
          state: ActionResultState.needAction,
          object: object,
        );

  /// Creates a new [ActionResult] instance with the [state] being [ActionResultState.failed].
  const ActionResult.failed({
    T? object,
  }) : this(
          state: ActionResultState.failed,
          object: object,
        );
}

/// An [ActionResult] state.
enum ActionResultState {
  /// Returned when the [Action] has been done with success.
  success,

  /// Returned when the [Action] needs another action before being achieved.
  needAction,

  /// Returned when the [Action] has failed.
  failed,
}
