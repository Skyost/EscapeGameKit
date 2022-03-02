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
}

enum ActionResultState {
  success,
  needAction,
  failed,
}
