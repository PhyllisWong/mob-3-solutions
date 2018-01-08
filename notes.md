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
