# 🕵️‍♂️ EscapeGameKit

EscapeGameKit is a package, enterely created using Flutter, that helps creating
[escape games](https://en.wikipedia.org/wiki/Escape_the_room).

It is better suited for web and desktop platforms (Windows, Linux, macOS) but can totally
be used on mobile platforms as well !

## Example

You'll find an example in the [`example`](https://github.com/Skyost/EscapeGameKit/tree/master/example)
directory. It's a little escape game called _ERROR 1980_ that I've created for my students. I've translated
it into english, so that you can try it [here](https://skyost.github.io/EscapeGameKit/game.html).

<img src="https://github.com/Skyost/EscapeGameKit/raw/master/example/screenshots/screenshot-1.png" width="30%"> <img src="https://github.com/Skyost/EscapeGameKit/raw/master/example/screenshots/screenshot-2.png" width="30%"> <img src="https://github.com/Skyost/EscapeGameKit/raw/master/example/screenshots/screenshot-5.png" width="30%">

<details>
  <summary>More screenshots</summary>

  <img src="https://github.com/Skyost/EscapeGameKit/raw/master/example/screenshots/screenshot-3.png" width="30%">
  <img src="https://github.com/Skyost/EscapeGameKit/raw/master/example/screenshots/screenshot-4.png" width="30%">
  <img src="https://github.com/Skyost/EscapeGameKit/raw/master/example/screenshots/screenshot-6.png" width="30%">
  <img src="https://github.com/Skyost/EscapeGameKit/raw/master/example/screenshots/screenshot-7.png" width="30%">
</details>

## Getting started

Everything you need in order to get started with this library is available on the
[wiki](https://github.com/Skyost/EscapeGameKit/wiki).

## Caveats

The plugin is currently in beta. Here's the list of things we (me, and hopefully any contributor 😀)
need to work on before release :

* [ ] **Better support of hot reload**. Currently, escape games doesn't support hot reload.
* [ ] **Better support of Android and iOS platforms**.
  The plugin is still untested on these platforms, but it should perfectly work. The only problem
  we may encounter is with tooltips.
* [ ] **Add fullscreen / custom window size support**. It should be possible using
  [`Transform.scale`](https://api.flutter.dev/flutter/widgets/Transform/Transform.scale.html) or
  something like that.

## Contributions

You have a lot of options to contribute to this project ! You can :

* [Fork it](https://github.com/Skyost/EscapeGameKit/fork) on Github.
* [Submit](https://github.com/Skyost/EscapeGameKit/issues/new/choose) a feature request or a bug report.
* [Donate](https://paypal.me/Skyost) to the developer.

Also if you've created something using this library, feel free to
[tell me about it](https://github.com/Skyost/EscapeGameKit/issues/new?assignees=Skyost&labels=creation&template=created_something.md&title=) !
