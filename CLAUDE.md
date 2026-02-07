# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CollectionViewGrids is an iOS demo app (Swift 5, UIKit) that showcases different `UICollectionViewCompositionalLayout` implementations. It is a single-target Xcode project with no external dependencies or package manager.

## Build Commands

```bash
# Build for simulator
xcodebuild -project CollectionViewGrids.xcodeproj -scheme CollectionViewGrids -sdk iphonesimulator -configuration Debug build

# Clean build
xcodebuild -project CollectionViewGrids.xcodeproj -scheme CollectionViewGrids clean build
```

There are no tests or linting configured in this project.

## Architecture

The app uses a catalog navigation pattern: `SceneDelegate` creates a `UINavigationController` with `CatalogViewController` as root. The catalog is a table view listing layout examples; tapping one pushes the corresponding view controller.

**Layout examples (each is a self-contained view controller):**

- **ImagesViewController** — 4-column responsive image grid using `UICollectionViewCompositionalLayout` with `UICollectionViewDiffableDataSource`. Contains two layout strategy functions (`makeCalculationsStrategy` using absolute dimensions, `useFractionalStrategy` using fractional dimensions) defined as nested functions inside `createSection()`. Handles rotation via `viewWillTransition` layout invalidation. Selection state is managed manually (not via `isSelected`) with animated `CAShapeLayer` borders on `ImageCell`.
- **CenterButtonViewController** — Single centered button in a compositional layout using flexible spacing.
- **StackViewViewController** — Vertical `UIStackView` inside a scroll view (non-compositional-layout alternative).

**Key patterns:**
- All UI is built programmatically (no storyboards/xibs). Cells use `static let identifier` for reuse registration.
- `ImageItem` is `Hashable` (with a `UUID` identity) for use with diffable data sources.
- `ImageCell` uses a `CAShapeLayer` overlay for its selection border, updated in `layoutSubviews` to stay circular.
