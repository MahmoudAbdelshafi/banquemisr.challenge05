# MovieApp

## Run Requirements
* iOS 17.4+
* Xcode Version 15.3+
* Swift 5.0+

## Overview
MovieApp is a modular iOS application built using Clean Architecture and MVVM. It fetches and displays now-playing movies and uses Core Data for caching, allowing offline access to movie data.

## High-Level Layers
* **Domain Layer**: Entities, Use Cases, and Repository Interfaces.
* **Data Layer**: Repository Implementations, API (Network), and Persistence DB (Core Data).
* **Presentation Layer (MVVM)**: ViewModels and Views.

## Modules
The project is organized into the following modules:
1. **Presentation**: Handles the UI and user interaction using SwiftUI.
2. **Domain**: Contains business logic and use cases.
3. **Data**: Manages data fetching and transformation.
4. **Networking**: Handles network requests and API communication.
5. **Caching**: Manages local data caching using Core Data.
6. **TMDB App**: The main app module that ties all the other modules together.

## Data Flow
1. `View (UI)` calls a method from `ViewModel (Presenter)`.
2. `ViewModel` executes a Use Case.
3. `Use Case` combines data from User and Repositories.
4. Each Repository returns data from a Remote Data Source (Network), Persistent DB Storage Source, or In-memory Data (Remote or Cached).
5. Information flows back to the `View (UI)` where the list of items is displayed.

## Dependency Direction
* `Presentation Layer` -> `Domain Layer` <- `Data Layer`
* `Presentation Layer (MVVM)`: ViewModels (Presenters) + Views (UI)
* `Domain Layer`: Entities + Use Cases + Repository Interfaces
* `Data Layer`: Repository Implementations + API (Network) + Persistence DB (Core Data)

## Layers Details

### Domain Layer
* Contains Entities and Use Cases.
* Contains Repository Interfaces for Dependency Inversion.

### Presentation Layer
* Contains the views with movie data observed from the ViewModels.
* **ViewModel**: Contains business logic.
* **UI Components**: Contains all the UI components necessary for displaying movie data.

### Data Layer
* Contains Repository Implementations that conform to interfaces defined in the Domain Layer.
  * **Note**: Data Layer conforms to interfaces defined in the Domain Layer to achieve Dependency Inversion.
* Contains DTOs and mapping objects.
  * **Note**: Data Transfer Objects (DTOs) are used as intermediates for mapping JSON responses to Domain objects and for mapping data to the persistent storage.

### Infrastructure Layer (Network)
* **Service / Networking**: Contains the Router enum responsible for API structure.
* **Endpoint**: Contains the BaseAPI singleton class with generic base API requests.
* **Encoding**: Contains necessary encoding methods for building URLs.

### Caching Layer
* Manages local data caching using Core Data.
* Contains the Core Data stack setup and caching repository implementations.