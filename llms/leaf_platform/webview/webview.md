# WebView

Full-featured WebView widget (`LeafWebView`) with a companion controller (`LeafWebViewController`). Supports URL/HTML/file/asset loading, JavaScript channels, navigation interception, dynamic height measurement, and platform-specific configuration for iOS (WebKit) and Android.

## API Reference

### LeafWebViewEventType (Enum)

| Value | Description |
|-------|-------------|
| `mailto` | `mailto:` link detected |
| `tel` | `tel:` link detected |
| `geo` | `geo:` link detected |

### Typedefs

| Typedef | Signature | Description |
|---------|-----------|-------------|
| `LeafWebViewOnBeforeLoaded` | `Function()` | Called before content loading starts |
| `LeafWebViewOnLoaded` | `Function()` | Called after content loading completes |
| `LeafWebViewOnLoaderBuilder` | `Widget Function()` | Builds a custom loading indicator widget |
| `LeafWebViewOnCreateWebViewController` | `Function(WebViewController)` | Provides raw `WebViewController` after creation |
| `LeafWebViewOnPageStarted` | `Function()` | Page started loading |
| `LeafWebViewOnPageFinished` | `Function()` | Page finished loading |
| `LeafWebViewOnHeightFinished` | `Function(double height)` | Document height measured after page load |
| `LeafWebViewOnNavigationDecision` | `bool Function(LeafWebViewEventType? type, String url)` | Return `true` to allow navigation, `false` to prevent |
| `LeafWebViewOnUrlChange` | `Function(String? url)` | URL changed |
| `LeafWebViewOnHttpError` | `Function(HttpResponseError error)` | HTTP error received |
| `LeafWebViewOnJavaScriptAlertDialogIOS` | `Future<bool?> Function(JavaScriptAlertDialogRequest)` | iOS JavaScript alert dialog |
| `LeafWebViewOnJavaScriptConfirmDialogIOS` | `Future<bool?> Function(JavaScriptConfirmDialogRequest)` | iOS JavaScript confirm dialog |
| `LeafWebViewOnJavaScriptTextInputDialogIOS` | `Future<String?> Function(JavaScriptTextInputDialogRequest)` | iOS JavaScript text input dialog |
| `LeafWebViewOnJavaScriptMessageReceived` | `Function(JavaScriptMessage)` | JavaScript channel message received |
| `LeafWebViewOnRegisterJavaScriptChannel` | `Function(WebViewController)` | Custom JavaScript channel registration |

### LeafWebView (StatefulWidget)

#### Constructor Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `controller` | `LeafWebViewController` | Yes | - | WebView controller instance |
| `uri` | `Uri?` | No | `null` | URL to load |
| `htmlString` | `String?` | No | `null` | HTML string to load |
| `htmlFile` | `String?` | No | `null` | Local HTML file path |
| `assetFile` | `String?` | No | `null` | Flutter asset path |
| `fullScreen` | `bool` | No | `true` | Whether to fill available height |
| `initHeight` | `double` | No | `0.0` | Initial height when not full screen |
| `backgroundColor` | `Color` | No | `Color(0x00000000)` | WebView background color |
| `allowAllowOrientation` | `bool` | No | `false` | Allow orientation changes for Android fullscreen video |
| `allowsBackForwardNavigationGestures` | `bool` | No | `true` | iOS swipe back/forward gestures |
| `useHybridComposition` | `bool` | No | `false` | Android hybrid composition mode |
| `isInspectable` | `bool` | No | `false` | iOS Web Inspector support |
| `userAgent` | `String?` | No | `null` | Custom user agent string |
| `loaderDelay` | `Duration?` | No | `null` | Delay before hiding loader after page load |
| `onInitBeforeLoaded` | `LeafWebViewOnBeforeLoaded?` | No | `null` | Called before loading starts |
| `onInitLoaded` | `LeafWebViewOnLoaded?` | No | `null` | Called after loading completes |
| `onCreateWebViewController` | `LeafWebViewOnCreateWebViewController?` | No | `null` | Provides raw `WebViewController` |
| `onPageStarted` | `LeafWebViewOnPageStarted?` | No | `null` | Page started callback |
| `onPageFinished` | `LeafWebViewOnPageFinished?` | No | `null` | Page finished callback |
| `onLoaderBuilder` | `LeafWebViewOnLoaderBuilder?` | No | `null` | Custom loader widget builder |
| `onHeightFinished` | `LeafWebViewOnHeightFinished?` | No | `null` | Document height callback |
| `onNavigationDecision` | `LeafWebViewOnNavigationDecision?` | No | `null` | Navigation interception |
| `onUrlChange` | `LeafWebViewOnUrlChange?` | No | `null` | URL change callback |
| `onHttpError` | `LeafWebViewOnHttpError?` | No | `null` | HTTP error callback |
| `onJavaScriptAlertDialogIOS` | `LeafWebViewOnJavaScriptAlertDialogIOS?` | No | `null` | iOS JS alert handler |
| `onJavaScriptConfirmDialogIOS` | `LeafWebViewOnJavaScriptConfirmDialogIOS?` | No | `null` | iOS JS confirm handler |
| `onJavaScriptTextInputDialogIOS` | `LeafWebViewOnJavaScriptTextInputDialogIOS?` | No | `null` | iOS JS text input handler |

#### Content Loading Priority

1. `uri` (URL request)
2. `htmlString` (inline HTML)
3. `htmlFile` (local file)
4. `assetFile` (Flutter asset)

#### Height Behavior

- **fullScreen = true**: Fills all available height from `LayoutBuilder`
- **fullScreen = false**: Measures `document.body.scrollHeight` after page load and resizes dynamically

### LeafWebViewController

#### Static Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `clearCookies()` | `Future<void>` | Clears all WebView and CookieManager cookies |
| `deleteAllData()` | `Future<void>` | Clears all web storage data |

#### Instance Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `dispose()` | `void` | Closes message stream and clears channel map |
| `loadRequest(Uri uri, {LoadRequestMethod method, Map<String, String> headers, Uint8List? body})` | `Future<void>` | Loads a URL with optional method, headers, and body |
| `loadHtmlString(String html, {String? baseUrl})` | `Future<void>` | Loads an HTML string |
| `loadFile(String absoluteFilePath)` | `Future<void>` | Loads a local file |
| `loadFlutterAsset(String key)` | `Future<void>` | Loads a Flutter asset |
| `addJavaScriptChannelName(String name, {required void Function(JavaScriptMessage) onMessageReceived})` | `void` | Registers a named JavaScript channel with a message handler |
| `addJavaScriptChannelFunc(LeafWebViewOnRegisterJavaScriptChannel func)` | `void` | Registers a custom channel setup function |
| `runJavaScriptReturningResult(String javaScript)` | `Future<Object>` | Executes JavaScript and returns the result |
| `getUserAgent()` | `Future<String?>` | Gets the current user agent |
| `setUserAgent(String userAgent)` | `Future<void>` | Sets a custom user agent |
| `clearCache()` | `Future<void>` | Clears the WebView cache |
| `clearLocalStorage()` | `Future<void>` | Clears local storage |
| `canGoBack()` | `Future<bool>` | Whether the WebView can navigate back |
| `canGoForward()` | `Future<bool>` | Whether the WebView can navigate forward |
| `goBack()` | `Future<void>` | Navigates back |
| `goForward()` | `Future<void>` | Navigates forward |
| `reload()` | `Future<void>` | Reloads the current page |

## Usage

### Basic URL Loading

```dart
final controller = LeafWebViewController();

LeafWebView(
  controller: controller,
  uri: Uri.parse('https://example.com'),
  onPageFinished: () {
    print('Page loaded');
  },
)
```

### HTML String Loading

```dart
LeafWebView(
  controller: controller,
  htmlString: '<h1>Hello</h1>',
  fullScreen: false,
  onHeightFinished: (height) {
    print('Content height: $height');
  },
)
```

### JavaScript Channel

```dart
final controller = LeafWebViewController();

controller.addJavaScriptChannelName(
  'MyChannel',
  onMessageReceived: (message) {
    print('Received: ${message.message}');
  },
);

LeafWebView(
  controller: controller,
  uri: Uri.parse('https://example.com'),
)
```

### Navigation Interception

```dart
LeafWebView(
  controller: controller,
  uri: Uri.parse('https://example.com'),
  onNavigationDecision: (type, url) {
    if (type == LeafWebViewEventType.tel) {
      // Handle phone link
      return false; // prevent WebView navigation
    }
    return true; // allow navigation
  },
)
```

### Clear All WebView Data

```dart
await LeafWebViewController.clearCookies();
await LeafWebViewController.deleteAllData();
```

### Controller Navigation

```dart
if (await controller.canGoBack()) {
  await controller.goBack();
}
await controller.reload();
```
