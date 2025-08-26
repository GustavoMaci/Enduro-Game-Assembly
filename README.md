# Enduro Game - MIPS Assembly Implementation

## Motivation

This project was developed as part of my Computer Architecture course, where I applied the knowledge acquired throughout the semester to create a complete game using MIPS Assembly language. The development of this game represents the culmination of my learning journey in low-level programming and computer architecture concepts. All the foundational knowledge and learning process that made this project possible are documented in my [Assembly Studies Repository](https://github.com/GustavoMaci/Assembly). This challenging journey taught me valuable lessons about processor architecture, memory management, and optimization techniques in assembly programming.

## Enduro

Enduro is a classic racing game originally released by Activision in 1983 for the Atari 2600. The game challenges players to complete a long-distance race against time and other vehicles on the road. The objective is to pass a certain number of cars each day to continue racing to the next day, with weather conditions and visibility changing throughout the game. The original Enduro was known for its progressive difficulty and day/night cycle, making it one of the most memorable racing games of its era.

## MIPS Mars

MIPS MARS (MIPS Assembler and Runtime Simulator) is an integrated development environment for programming in MIPS assembly language. Developed by Pete Sanderson and Kenneth Vollmar, MARS provides a user-friendly interface for writing, assembling, and debugging MIPS programs. It includes various tools such as a text editor, assembler, runtime simulator, and debugging features that make it ideal for educational purposes and learning computer architecture fundamentals.

**To download MARS MIPS Simulator:**
1. Visit the official MARS download page
2. Download the latest version (typically a .jar file)
3. Ensure you have Java Runtime Environment installed
4. Run the JAR file using `java -jar Mars.jar` command

## Game

<img width="638" height="316" alt="image" src="https://github.com/user-attachments/assets/1904c555-ea67-4c2b-aac2-7a8b4807f0e9" />
<img width="637" height="317" alt="image" src="https://github.com/user-attachments/assets/7e409b7d-dd6d-40f1-b9d8-502bf8fe1ac9" />




## How to Run

Follow these steps to run the Enduro game on MARS MIPS Simulator:

1. **Download and Setup MARS:**
   - Download MARS MIPS simulator from the official source
   - Open MARS and load the `Final-Version.asm` file

2. **Configure Bitmap Display:**
   - Go to `Tools` → `Bitmap Display`
   - Set the following parameters:
     - Unit Width in Pixels: 4
     - Unit Height in Pixels: 4
     - Display Width: 512
     - Display Height: 256
   - Click "Connect to MIPS" to link the display

3. **Configure Keyboard Input:**
   - Go to `Tools` → `Keyboard and Display MMIO Simulator`
   - Click "Connect to MIPS" to enable keyboard input

4. **Run the Game:**
   - Assemble the program (Ctrl+R)
   - Run the simulation (Ctrl+E)
   - Use the following controls:
     - Press "A" to move left
     - Press "D" to move right

5. **Gameplay:**
   - The game will start automatically after running
   - Control your vehicle to avoid obstacles and other cars
   - The game features progressive difficulty and scoring system

## Acknowledgments

I would like to express my sincere gratitude to Professor **Braulio Wanderley** for his exceptional guidance and mentorship throughout the Computer Architecture course. His profound knowledge, teaching methodology, and continuous support were instrumental in my understanding of computer architecture concepts and assembly programming. The skills and knowledge imparted during his classes provided the foundation that made this project possible. 
