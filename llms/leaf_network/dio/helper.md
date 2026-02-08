# LeafDioHelper & LeafDioMediaMimeType

Utility for converting `LeafMultipartFile` (from `leaf_common`) into Dio's `MultipartFile` with proper MIME type. Includes media MIME type enum.

## API Reference

### LeafDioMediaMimeType (enum)

| Value | String | Description |
|-------|--------|-------------|
| `image` | `'image'` | Image MIME type prefix |

### LeafDioMediaMimeType Extension

| Property | Type | Description |
|----------|------|-------------|
| `value` | `String` | MIME type string (e.g., `'image'`) |

### LeafDioHelper

#### Methods

| Method | Return Type | Description |
|--------|-------------|-------------|
| `convertFromFile(file, {mediaMimeType})` | `MultipartFile` | Convert `LeafMultipartFile` to Dio `MultipartFile` |

#### convertFromFile Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `file` | `LeafMultipartFile` | Yes | - | Source file from `leaf_common` |
| `mediaMimeType` | `LeafDioMediaMimeType` | No | `LeafDioMediaMimeType.image` | MIME type category |

#### Behavior

- Extracts file path and extension from `LeafMultipartFile`
- Converts `.jpg` to `.jpeg` for MIME compliance
- Sets filename from `file.getPayload()`
- Sets `contentType` to `MediaType(mediaMimeType.value, extension)`
- Throws `LeafMessageException` if path or extension is null

## Usage

### Convert File for Upload

```dart
final helper = LeafDioHelper();
final leafFile = LeafMultipartFile.fromUri(uri: fileUri, payload: 'profile');
final multipart = helper.convertFromFile(leafFile);

final formData = FormData.fromMap({
  'avatar': multipart,
});

await service.post<User, Null>('/users/1/avatar', data: formData);
```

### Upload Multiple Images

```dart
final helper = LeafDioHelper();
final multiparts = files.map((f) => helper.convertFromFile(f)).toList();

final formData = FormData.fromMap({
  'images': multiparts,
});
```
