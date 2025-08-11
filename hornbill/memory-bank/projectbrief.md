# Hornbill App - Project Brief

## Core Mission
Create a cross-platform Flutter application that provides a modern, intuitive file manager interface for Eagle libraries using the eagle_org_layer package.

## Project Goals
- **Modern UI/UX**: Provide a superior user experience compared to Eagle.cool
- **Cross-Platform**: Native performance on Windows, macOS, Linux, iOS, Android, and web
- **Real-time Search**: Fast, responsive search and filtering capabilities
- **Metadata Management**: Rich metadata display and editing capabilities
- **Performance**: Handle large libraries efficiently with smooth scrolling and quick loading

## Target Users
- Digital asset managers and designers using Eagle libraries
- Teams needing collaborative file organization
- Users seeking a modern alternative to Eagle.cool
- Power users requiring advanced search and filtering

## Core Requirements
1. **Library Management**:
   - Directory picker for library selection
   - Library validation and error handling
   - Multiple library support

2. **File Browser Interface**:
   - Grid and list view modes
   - File type icons and thumbnails
   - Metadata display in sidebar
   - Drag and drop support

3. **Search and Filtering**:
   - Real-time text search
   - Tag-based filtering
   - Folder-based filtering
   - Advanced search combinations

4. **State Management**:
   - BLoC pattern for predictable state
   - Efficient caching and memory management
   - Responsive UI updates

## Success Criteria
- Faster library loading than Eagle.cool
- Smooth 60fps scrolling through large libraries
- Intuitive search with instant results
- Cross-platform consistency
- Zero data corruption or loss

## Technical Foundation
- **Framework**: Flutter 3.8.1+
- **State Management**: flutter_bloc
- **File Operations**: eagle_org_layer package
- **UI Framework**: Material Design 3
- **Architecture**: Clean Architecture with BLoC pattern

## Unique Value Proposition
- Open source alternative to proprietary Eagle.cool
- Modern Flutter UI with native performance
- Enhanced search and filtering capabilities
- Cross-platform deployment from single codebase
- Extensible architecture for future features
