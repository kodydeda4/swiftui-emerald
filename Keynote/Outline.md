# Presentation Outline

the people are technologically savy
should be a conversational tone
they want you to present something, not the slides, but the slides should be an aid
they are listening ot your words

talk about what you wanted to achieve at the beginning of the class

get to demo @ minute 5
get out at like minute 12




## 1. Introduction

Over the last year I found myself interested in the Linux community.  I started watching Youtubers like Luke Smith, Distrotube, Mental Outlaw, to name a few.  I first became interested in this when I came across these screenshots:

<https://github.com/AdamWagner/stackline>

<!-- **screenshots** -->

<!-- I really enjoyed seeing a level of personality and customization shine through yadayadyasdyasdf -->

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

You may be wondering _"How come I haven't heard of this before?"_

Well, the truth is, while Tiling Window Managers do offer some extra features & functionality, and are increasingly common within the Linux Community, they're not that commonly used outside of it. This mainly comes down to their difficultly in installing and configuring them.

The process for getting one up and running looks like this:

- Install the program through the command line.
- Read through the Github or MAN documentation to figure out how it works.
- Write your preferences into a configuration file in the programming language it was created in.

PS. The configuration file, also called a dotfile, gets its name by the dot prefix before it's name, meansing it's hidden by default within Finder & Windows File Explorer. This means you gotta open / edit it in the terminal..  simple right? ;)

Despite this, there are actually quite a few out there, each with their own nuances and configurations.

To name a few:

- DWM (configured in C)
- XMonad (configured in Haskell)
- i3 (configured in Bash)
- QTile (configured in Python)
- Awesome (configured in Lua)

### 1.4 Examples

<!-- Need to talk about Amethyst here -->
On the mac, the most featured rich tiling window manager is called Yabai.

Unfortunately, like the others, it requires you to configure the program through a dotfile.
It also requires you to install, run, and configure a seperate program called SKHD to actually create/use keybindings.

After some reading and configuration, I finally got it to work how I wanted it to.

I was extremely impressed by the efficiency and utility of the program, and I was excited to show it off to my brother (also a CS Major).  **show video of it in action**.  

However, I knew the program could do more, I just didn't know how, and didn't feel bothered to learn at the time.




<!-- That last one, Yabai, is one of only two TWM for the mac, the other one, called Amethyst actually has a GUI, but is lacking for reasons i'll go into later.


Yabai actually asks you to configure two seperate programs.

The first is for the actual tiling window manager,
the second is for skhd, a program that configures keyboard shortcuts.  

To configure these programs, you have to read through documentation on Github, and type up your preferences into a file hidden on your desktop called a `dotfile`.  

This means that a lot of the options and capability for the program can never actually be realized.  
Show examples.

use as a segway into demo - "That's why I decided to create what i'm about to show you."

vim keys, vim lol -->


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
