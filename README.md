# X-Force 2
A game engine for round based tactic games.

It is a rewrite of [X-Force:FFD] using the [Godot Engine].

> X-Force:FFD is a game in the style of the old classics UFO: Enemy Unknown, XCOM: Terror from the Deep and XCOM: Apocalypse, where the player defended the earth with a military organization against an invasion from outer space. These classic weres at their time a unique mixture of research, strategy and tactics -- a mixture which hasn't been imitated very often since then.
>
> The implementing of all game aspects by gamesets and the gameset studio is the great strength of X-Force. Every interested gameset creator can provide all players with his own history and story, including new aliens and science projects.

X-Force 2 will increase the strength of [X-Force:FFD] and provide more flexibility for gameset creators.
Thus, it is not limited to "Humans vs Aliens" games.

## Preview

next Preview is coming soon

## Chat

If you have any Questions, you can use
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Andi-K/xForce2?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## License

GPL 3?

## Versioning

Format: X.Y.Z

X = development Phase
Y = a increase indicate a big or breaking change (0.2.0 is may not fully compatible to 0.1.7)
Z = increase by every new data.pck download, set to 0 if Y is increased

### Development Phase "0" (current)

 - everything can change
 - everything can break
 - Master branch = "unstable" developing branch
 - Bug-fixes have low priority ("new Features first")
 - no Translations
 - only 2 gamesets: a small showcase and tutorial ("Demo") and a promoted beginner-friendly gameset (Diary of William Walker?)
 - Development focus: Game basics

### Phase 1

 - new developing branch, Master branch = more stable "testing" branch
 - less breaking changes
 - Artist and Translators can start their work
 - one more promoted gameset (The Galactic War?)
 - Development focus: Ground Combat

### Phase 2

 - no breaking changes
 - no new big features
 - "stable" Downloads
 - Bug-fixes have high priority
 - Development focus: Tools for gameset, map and tileset creators
 - support for external gamesets

### Phase 3

We reached the current Goal and got:

 - (nearly) all features of X-Force:FFD 0.917
 - + some common requested improvements and features (except multiplayer and realtime support)
 - 2 complete gamesets
 - native Linux and Windows binaries (+MacOS if someone test it)

We will work on:
 - better performence (port slow GD-Scripts to C++)
 - artificial intelligence
 - future improvements
 - support for Android? Touchscreens? HTML?


## How to contribute

 * Ask how you can help
 * [Download Godot] ~~1.1~~ 2.0 Alpha (10/03/15) and install it
 * [fork](https://guides.github.com/activities/forking/) this repository
 * clone your repository
 * Run GoDot and ’Scan’ the src directory. After this you can ’edit’ the X-Force 2 Engine or Launcher
 * make your changes
 * commit and push to your repository
 * start a Pull Request (PR)

#### useful Links

 - [Git Guide](http://rogerdudler.github.io/git-guide/)
 - [Godot Manual](http://fr.flossmanuals.net/godot-game-engine/about-this-book/) / [Non-English Manuals](http://www.godotengine.org/projects)
 - [Godot Tutorials](http://www.gamefromscratch.com/page/Godot-Game-Engine-tutorial-series.aspx)
 - [Godot Youtube Tutorials](https://www.youtube.com/playlist?list=PLPI26-KXCXpBtZGRJizz0cvU88nXB-G14)
 - [Markdown (.md) Howto](https://guides.github.com/features/mastering-markdown/)



[X-Force:FFD]: http://www.xforce-online.de/ "X-Force: Fight For Destiny"
[Godot Engine]: http://www.godotengine.org/
[Download Godot]: http://www.godotengine.org/documents/
