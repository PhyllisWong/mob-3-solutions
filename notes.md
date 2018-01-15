Mob3 - Persistence and dependency management

## Intro to dependency management
* Libraries and frameworks - guidelines and convention for implementing code.
* Libraries are a collection of code that you call in your program
* a framework is a bundle that contains shared libraries, sub directories of headers and other resources and files.
* generally follows the Hollywood principle, "don't call us, we call you." - inversion of control
* examples of frameworks in swift: UIKit, Foundation, Swift Standard libraries.
* examples if libraries: import Random, Alomofire, ect.
* Add libraries / frameworks to program: static linking, and dynamic linking.

#### Static vs Dynamic Linking
* Static linking - dependencies are added to your project at compile time. Cons: app bundle is larger, longer download times, can't share the dependencies, can't update the dependencies after binary shipped.
* Dynamic linking - only references to dependencies are stored in executable. dependencies themselves are loaded dynamically at runtime. Con: more uncertainty about enviro in which app will run. Slows down the app launch time.
* system frameworks are all linked dynamically
* third party dependencies can be linked dynamically and statically since iOS8, prior only static libraries were allowed.

#### dependency managers
* Cocoapods - most popular
* Carthage - second most popular
* Swift Package Manager - released with swift 3
* Manual dependency management : need to maintain dependencies manually
* non-trivial to update to new versions of your dependencies.
* Cocoapods and Carthage have been around for years, maintained by third parties
* SwiftPackageManager - updated by apple and is open source

## Wed Jan 10
### Objectives

#### UserDefaults
* Allows us to store state in a app as simple key value pairs
* Use cases: settings, themes, levels, user data.

#### Pros
* wuick to store native data types

#### Cons
* not secure: do not store passwords/ api keys in the userDefaults
* Cannot perform any complex queries, like user objects.key


### Swift KeyChain
* Service that iOS provides, that is not part of your app.
* When you delete the app, it does not delete the keychains key / value pair.
* Everything is encrypted by Apple, and is considered safe.
* Stored sensitive information, such as passwords, auth tokens.
* You can share keychain items between apps.
* You can group keychain identifiers, so they can share the credentials.

#### Cons
* Items persist even with app is deleted
* Not used to store complex objects, just simple key / value stores

#### NSCoder - Library
* Encoding/Decoding
* Encoding a representation that can be stored on disc, to be retrieved laster
* Decoding
* Can be worked side by side with UserDefaults

### Filesystem
* every app is in it's own isolated sandbox (your app)
* each app is isolated from the rest of the system (prevents the app from reaching out into essential operating files)
* sandbox has 2 containers:
    1. Bundle container: all required resources, frameworks, assets, code. iOS builds it at compile time
        * once you ship it, you cannot change anything in the bundle
    1. Data container: documents, library, temp folder. Generated when you install the app. Behaves like finder. Store user generated content. Backed up by iTunes. Backups can be made available via iTunes, File-sharing.
    1. Temp folder gets cleared by the file system
    1. Library: used to store files that you don't want to expose to the user
        * sub directory under the library is called caches
        * cache gets cleaned out by the iOS.

* Directories are related to core data. Set up of core data relies on some knowledge of the file system.

#### Using the File manager
