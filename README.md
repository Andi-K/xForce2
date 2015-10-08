# X-Force 2
A game engine for round based tactic games.

It is a rewrite of [X-Force:FFD] using the [Godot Engine].

Goal is to provide
 - a easier to maintenance Code base
 - (nearly) all features of X-Force:FFD 0.917
 - common requested improvements and features except multiplayer and realtime support
 - 2 complete gamesets
 - native Linux and Windows binaries (+MacOS if someone test it)


> X-Force:FFD is a game in the style of the old classics UFO: Enemy Unknown, XCOM: Terror from the Deep and XCOM: Apocalypse, where the player defended the earth with a military organization against an invasion from outer space. These classic weres at their time a unique mixture of research, strategy and tactics -- a mixture which hasn't been imitated very often since then.
> 
> The implementing of all game aspects by gamesets and the gameset studio is the great strength of X-Force. Every interested gameset creator can provide all players with his own history and story, including new aliens and science projects.

X-Force 2 will increase the strength of [X-Force:FFD] and provide more flexibility for gameset creators.
Thus, it is not limited to "Humans vs Aliens" games.

## License

GPL 3?

## Versioning

Format: X.Y.Z

X = development Phase

  Y = a increase indicate a big or breaking change (0.2.0 is may not fully compatible to 0.1.0)

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

We reached the current goal :)

 - Development focus: artificial intelligence and future improvements
 - support for Android? Touchscreens? HTML?

## How to contribute

### Developers

[Download Godot] 1.1, install it and clone this repository.
If you run Godot the first time ’Import’ the src/engine.cfg after this you can ’edit’ or ’run’ X-Force 2.

#### useful Links

 - [Git Guide](http://rogerdudler.github.io/git-guide/)
 - [Godot Manual](http://fr.flossmanuals.net/godot-game-engine/about-this-book/)
 - [Godot Tutorials](http://www.gamefromscratch.com/page/Godot-Game-Engine-tutorial-series.aspx)
 - [Godot Youtube Tutorials](https://www.youtube.com/playlist?list=PLPI26-KXCXpBtZGRJizz0cvU88nXB-G14)
 - [Markdown (.md) Howto](https://guides.github.com/features/mastering-markdown/)



[X-Force:FFD]: http://www.xforce-online.de/ "X-Force: Fight For Destiny"
[Godot Engine]: http://www.godotengine.org/
[Download Godot]: http://www.godotengine.org/documents/2
