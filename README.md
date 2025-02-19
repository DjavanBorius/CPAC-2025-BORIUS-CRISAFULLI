# DJ Art Designer

## Overview
DJ Art Designer is a program that embrace both Novel Instrument Design and Generative Art.

## Description
The purpose of DJ Art Designer is to enhance the performance of DJs by creating visuals associated to the music in order to give audience a visual feedback and involving them more, increasing the emotional aspects that live music shows convey. 
The different visual art modules are interacting with the music and make the enchantment for the show bigger.
All modules are coded in Processing except for fractal module that is coded with TouchDesigner. This increases the number of options we have to make visual art aided by a computer.
The modules are:

1. **Chladni Patterns**:
Visual that reminds of grains on a plate which moves depending on the fundamental frequency of the sound, assuming different shapes (Chladnni figures).

2. **Circle Dancing**:
Visual where circles move in association to the beat. Thought for disco music, the program can show one or five circles depending on different parts of the song.

3. **Interactive Painting**:
External devices are associated with colors, and they send OSC messages to the program in order to display splat spots on the screen that disappear after a short time. Thought to involve audience in the performance.

4. **Fractal Art**:
Fractal art visuals that change according to the music.


In order to use it the DJ just need to transfer sound to the program and to send OSC messages to switch between different visuals.
So the chain to use the program properly is: 
- Collect the sound from the DJ software (rekordbox) and access it in Processing, this is made possible thanks to the Sound library in Processing;
- Connect processing to Touch Designer for the fractal art module;
- Connect another device in order to send the OSC messages, this is made possible thanks to the oscP5 library in Processing;
- Play the music!




## **Challenges, accomplishment and lessons learned**

- **Challenges**:
  During this project we faced many problems, principally one was to make the project work in real time with a good resolution (and with no budget). Indeed there is no clear audio connection from the software we use so we have to use a virtual line audio cable. It exist free version of hardware like this but they are not optimal and come with a lot of imperfection making the fast fourier transform and other feature extraction calculations in Processing with flaws.
  Similarly we had no access to several devices to make an optimal interaction app. During our video presentation we are using what’s within our reach so telephones with OSC free apps.

- **Accomplishment**: 
  The best accomplishment we are proud of is making the app work in real time with minimum delay between the music and the sound (near 0 seconds). Indeed the pipeline from rekordbox to the projection through a projector is long. However we optimized it and made it work flawlessly.

- **Lessons Learned**: 
  We learnt many things about the interaction of agents coming from different softwares and some of us discovered about the DJ world.

## Technologies
- **Softwares**: Processing, Reckordbox, TouchDesigner, Virtual line Audio Cable.
- **Softwares on phone**: OSC Controller, Sensor2OSC, Sound Cool OSC
- **Libraries**: Processing.Sound, OscP5
- **Hardware**: computer, different phones (minimum 3)
- **Coding languages**: Processing (Java language) and TouchDesigner

---

## Students
- Djavan Borius (djavan.borius@mail.polimi.it): worked on the interaction of the different software (Processing, reckordbox and ToucheDesigner). Worked on the modules Chladni patterns, fractal and interactive painting. Worked on the presentation, the report and video making.
- Andrea Crisafulli (andrea.crisafulli@mail.polimi.it): worked on the modules Circle Dancing, features. Worked on the presentation, the report and video making.

This project was developed as part of the Creative Programming and Computing course at Politecnico di Milano (2024/2025).

---

## Other information and explainations

Files in processing and TouchDesigner are the code.
To make everything work all devices need to be connected to the same IP adress. Make sure you changed the line related to the OSC messages in the codes (OSC message and project_final)
If you want bespoke feature you can easily modify the class of circle and painting. 
For the TouchDesigner code you need to launch it in the same time as the processing code. If you have a paying version of TouchDesigner you can use the functions Spout of TouchDesigner to collect the 
video in processing.