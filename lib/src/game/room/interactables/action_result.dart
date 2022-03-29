class ActionResult<T> {
  final ActionResultState state;
  final T? object;

  const ActionResult({
    required this.state,
    this.object,
  });

  const ActionResult.success({
    T? object,
  }) : this(
          state: ActionResultState.success,
          object: object,
        );

  const ActionResult.needAction({
    T? object,
  }) : this(
          state: ActionResultState.needAction,
          object: object,
        );

  const ActionResult.failed({
    T? object,
  }) : this(
          state: ActionResultState.failed,
          object: object,
        );
}

enum ActionResultState {
  success,
  needAction,
  failed,
}
