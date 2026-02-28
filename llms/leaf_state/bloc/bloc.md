# BLoC Utilities

BLoC state management utilities providing a base state class, observer with callbacks, screen-level consumer widget, and event debounce transformer.

Re-exports: `flutter_bloc`, `bloc_concurrency`

## API Reference

### BlocBaseState

Equatable base state class with an optional exception field for error propagation.

| Property | Type | Description |
|----------|------|-------------|
| `exception` | `Object?` | Error/exception attached to the state |

| Constructor | Parameters | Description |
|-------------|------------|-------------|
| `BlocBaseState` | `{required Object? exception}` | Creates a base state with exception |

Extends `Equatable` with `props` containing `[exception]`.

### LeafBlocObserver

BLoC observer that delegates `onChange` and `onError` to optional callbacks.

| Property | Type | Description |
|----------|------|-------------|
| `onChangeCallback` | `BlocObserverOnChangeCallback?` | Called on every state change |
| `onErrorCallback` | `BlocObserverOnErrorCallback?` | Called on every BLoC error |

#### Type Aliases

| Alias | Signature |
|-------|-----------|
| `BlocObserverOnChangeCallback` | `void Function(BlocBase, Change)` |
| `BlocObserverOnErrorCallback` | `void Function(BlocBase, Object, StackTrace)` |

### BlocScreenConsumer\<B, S\>

StatelessWidget that wraps `BlocConsumer` to separate success and error listeners. Supports two error detection modes: (1) `BlocBaseState.exception` for backward compatibility, (2) custom `errorWhen` callback for flexible error conditions.

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `builder` | `BlocWidgetBuilder<S>` | Yes | Widget builder for the state |
| `successListener` | `BlocScreenSuccessListener<S>` | Yes | Called on successful state changes |
| `errorListener` | `BlocScreenErrorListener<S>?` | No | Called when error is detected |
| `errorWhen` | `bool Function(S state)?` | No | Custom error condition callback |

#### Type Aliases

| Alias | Signature |
|-------|-----------|
| `BlocScreenSuccessListener<S>` | `void Function(BuildContext context, S state)` |
| `BlocScreenErrorListener<S>` | `void Function(BuildContext context, dynamic exception)` |

### debounce\<Event\>()

Event transformer that debounces BLoC events using `stream_transform`.

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `duration` | `Duration` | No | `300ms` | Debounce duration |

Returns `EventTransformer<Event>` that debounces events then switches to the latest mapped stream.

## Usage

### Initialize Observer

```dart
void main() {
  final observer = LeafBlocObserver()
    ..onChangeCallback = (bloc, change) {
      debugPrint('${bloc.runtimeType} $change');
    }
    ..onErrorCallback = (bloc, error, stackTrace) {
      debugPrint('${bloc.runtimeType} $error');
    };
  Bloc.observer = observer;

  runApp(const MyApp());
}
```

### Define State

```dart
class CounterState extends BlocBaseState {
  final int count;

  const CounterState({
    required this.count,
    required super.exception,
  });

  CounterState copyWith({int? count, Object? exception}) {
    return CounterState(
      count: count ?? this.count,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [count, ...super.props];
}
```

### Screen Consumer (BlocBaseState 방식)

```dart
BlocScreenConsumer<CounterBloc, CounterState>(
  builder: (context, state) {
    return Text('Count: ${state.count}');
  },
  successListener: (context, state) {
    // Handle successful state changes
  },
  errorListener: (context, exception) {
    // Show error dialog or snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $exception')),
    );
  },
)
```

### Screen Consumer (errorWhen 방식)

```dart
BlocScreenConsumer<MyBloc, MyState>(
  builder: (context, state) {
    return Text('Data: ${state.data}');
  },
  successListener: (context, state) {
    // Handle successful state changes
  },
  errorWhen: (state) => state.hasError,
  errorListener: (context, state) {
    // state itself is passed when errorWhen triggers
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error occurred')),
    );
  },
)
```

### Debounce Events

```dart
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState.initial()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: debounce(duration: const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    // Only fires after 500ms of inactivity
    final results = await searchRepository.search(event.query);
    emit(state.copyWith(results: results));
  }
}
```
