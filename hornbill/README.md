# Hornbill

A cross-platform file manager application built with Flutter that provides an open-source alternative to Eagle.cool. Hornbill enables you to organize, search, and manage your digital assets using the Eagle library format.

## Features

- **Eagle Library Support**: Load and manage existing Eagle.cool libraries
- **Cross-Platform**: Runs on Windows, macOS, Linux, iOS, Android, and web
- **File Management**: Browse, search, and organize digital assets
- **Metadata Panel**: View detailed information about selected files
- **Search Interface**: Find files by name with real-time filtering
- **Modern UI**: Material Design interface with responsive layout

## Getting Started

### Prerequisites
- Flutter SDK (>=1.17.0)
- Dart SDK (>=3.8.1)

### Installation

1. Clone the repository
2. Navigate to the hornbill directory
3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```

## How It Works

Hornbill uses the Eagle Organization Layer package to:
- Detect and validate Eagle library formats
- Load library metadata and file information
- Provide a user-friendly interface for asset management
- Enable cross-platform access to your organized files

## Current Status

This is a working prototype that demonstrates:
- Library loading and validation
- File browsing and metadata display
- Search functionality
- Cross-platform compatibility

## Development

Built with:
- **Flutter**: Cross-platform UI framework
- **BLoC**: State management architecture
- **Eagle Organization Layer**: Core library management package

## License

This project is open source and available under the [LICENSE](LICENSE) file.
