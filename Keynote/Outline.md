# Presentation Outline

## 1. Introduction

Over the last year I found myself interested in the Linux community.  I started watching Youtubers like Luke Smith, Distrotube, Mental Outlaw, to name a few.

### 1.1 Floating Window Managers

I'm going to start by defining something we're all familiar with, but that most of us never knew had a name. It describes how windows are organized & laid out on the desktop. The word is **Window Manager**.
  
On a standard Mac or Windows machine, we use something called a **Floating Window Manager**.  It works by letting us

- Click and drag windows to wherever you want.
- Resize windows by clicking & dragging near the edges.

For the most part, floating window managers do a pretty good job. They're incredibley simple to use and they allow us to freely resize windows to get our work done.

Today however, i'm going to introduce you to an alternative that I hope you find somewhat interesting.

### 1.2 Explain the solution - Tiling Window Managers

**Tiling Window Managers** attempt to solve three problems that Floating Window Managers inherenty suffer from:

- Speed.
- Efficiency.
- Organization.

They do so simply by:

- Automatically resizing / moving windows for you into non-overlapping frames.
- Empowering you with keyboard shortcuts for focusing, moving, & resizing windows.

### 1.3 The problem with Tiling Window Managers

You may be wondering "How come I haven't heard of this before?"

The truth is that while Tiling Window Managers do offer more features & functionality, they're not that commonly used outside of the Linux community. Despite this, there are actually quite a few out there, each with their own nuances and configurations.

- DWM
- XMonad
- i3
- QTile
- Awesome


This is mostly due to how they're installed and configured. 

------------------------------------------------------------------------------------------
### 1. Getting Started

To even get started using a tiling window manager, you have to install the program through the terminal.  

For programmers like us, that might be easy, but for most users that comes across as really difficult.

It sends a lot of people away before they ever start using it because they can't understand what it's supposed to do in the first place, and even if they did, it would seem overly complicated or difficult to install a program through the terminal.

To make things even more complicated, some tiling window managers DO NOT come with built in way of adding shortcuts.  Yabai is like this, it actually relies on a completely seperate program to configure keyboard shortcuts, which is also installed and configured via the terminal.


### 2. Configuration

To configure these programs, you have to read through documentation, and be somewhat familiar with a programming language.

DWM is written & configured in C
XMonad is written & configured in Haskell
Awesome is written & configured in Lua
etc etc 

In the case of Yabai, the configuration is just written in plaintext as a series of terminal commands.

### 3. Extensibility



I wanted to make a program that was way , and super easy to use. That is why I created Emerald.

### Random

Explain how they are normally configured and why this is annoying

People have a hard time figuring out how to use them, even for the basics.

I wanted to make a program that was way , and super easy to use. That is why I created Emerald.

The main problem is that they're not so easy to use,
You have to install the program through the command-line
You have to read through documentation
And you have to configure two seperate programs, the first is for the actual tiling window manager, and the second is for skhd, a program that configures keyboard shortcuts.  To configure these programs, you have to read through documentation on Github, and type up your preferences into a file hidden on your desktop called a `dotfile`.  This means that a lot of the options and capability for the program can never actually be realized.  Show examples.


------------------------------------------------------------------------------------------


Explain the problems with Tiling Window Managers
use as a segway into demo - "That's why I decided to create what i'm about to show you."

vim keys, vim lol

## 2. Live Demo

Live demo of Emerald

- **show live keyboard shortcuts**
- set the logo as your wallpaper.
- show it off using spotlight search
- write a list of things you want to show off here:
  1. toggle between floating, tiling, and stacking modes.
  2. toggle gaps/padding
  3. focus, resize, swap
  4. how it plays with other keyboard shortcuts (spotlight search, cmd H, cmd M, cmd Q, cmd TAB, option + arrowkeys for text, cmd+ arrowkeys for text, cmd + l to start searching in safari.)
  5. Mouse follows focus
  6. Transparency
  7. Always on top
  8. Shadows

## 3. Explain what you built and how you created it

Explain how you wanted to make something simple and easy to use

### 3.1 SwiftUI

### 3.2 TCA

### 3.3 Functional Programming

## 4. Recap

### 4.1 Three things I learned from building this project

I've learned a lot by building this project..

#### 1. Swift & Functional Programming

1. Value vs mutation - Structs vs Classes.
2. Higher order functions (map/filter/reduce).
3. Closures (UI Buttons).
4. Enumerations & Type Safety.

#### 2. MVVM Architectural Patterns

1. TCA Features - State, Action, Environment.
2. TCA Pullbacks.
3. State tells how the Views to draw themselves, views should be dumb.

#### 3. Learn through play

_The most important lesson._

1. Learn through playing instead of planning and getting your hands dirty.
2. Efficiency - when you become comfortable you tend to focus on the familiar to be more efficient.  This is a mistake - when you give it away, you get it twice over. Allow yourself to 'waste' time by learning new things.
3. Embrace failure and experimentation.
   1. Makes learning self-evident.
   2. Example - planning
      1. Before I started the project, I had envisioned that the project would only last a couple of weeks.
      2. I got lost because I didn't have a plan, refactored the same thing multiple times chasing simplicity.
      3. By the time I had refactoring the program to where I wanted it to be, I realized that if I had actually spent some time writing out a general plan, I would have something to stick to, and I would have avoided hours walking in circles.
      4. Despite this, the failure and stupidity made the lesson stick.

### 4.2 Future plans

- Development
  - Implement AWS.
  
- Webflow
  - Create & host a website for the product.
  
- Marketing
  - Research FB & Google Ad compaigns.
  - Market to specific Youtube audiences.
  
- Move on
  - Begin developing Fitness App.

### 4.3 Resources

- PaulHudson
  - Recommended starting point.
  - Short, concise tutorials about SwiftUI.
  - Build your first app in ~ 30 minutes.
  - <https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ>

- RVSRVS Playgrounds
  - Learn Swift through interactive playgrounds.
  - Covers everything from the basics all the way up to advanced techniques & concepts.
  - <https://github.com/rvsrvs/learn-swift>

- DesignCode
  - Inspiring UI designer.
  - Teaches SwiftUI, React, & Flutter.
  - <https://www.youtube.com/channel/UCTIhfOopxukTIRkbXJ3kN-g>

- PointFree
  - Video-series exploring functional programming and Swift.
  - They are wizards.
  - <https://www.pointfree.co>

- Yabai
  - <https://github.com/koekeishiya/yabai>

- SKHD
  - <https://github.com/koekeishiya/skhd>

### 4.4 Conclusion

LinkedIn
<https://www.linkedin.com/in/kodydeda4/>

Github
<https://github.com/kodydeda4>
