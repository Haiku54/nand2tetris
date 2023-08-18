# nand2tetris - Projects 7-11

The "Nand to Tetris" course provides a deep dive into the intricacies of computer systems, spanning from foundational hardware constructs to sophisticated software hierarchies. This repository focuses on the software aspect, specifically projects 7-11, which center around the construction of a compiler for the Jack programming language.

The Jack language, a high-level programming language, is first translated into an intermediate VM (Virtual Machine) language. This VM representation abstracts away many of the complexities of direct hardware interaction, serving as a bridge to the next stage. The VM commands are then further compiled down to the Hack assembly language, which is designed to run directly on the Hack hardware platform.

## Compiler Construction Overview:

- **Tokenization & Parsing**: The Jack source code is broken down into its fundamental components (tokens) and structured into a syntax tree.
- **VM Code Generation**: The parsed Jack code is translated into VM commands, an intermediate representation.
- **Assembly Code Generation**: The VM commands are compiled into Hack assembly instructions, ready for execution on the Hack platform.

This repository showcases the entire process, providing a hands-on approach to compiler construction, from high-level source code down to assembly-level instructions.

## Projects Overview

### Project7 - VM Parser & Code Writer
This project focuses on VM parsing and code writing. It reads from a directory containing .vm files, processes various VM commands, and writes the results. The primary goal is to translate VM commands into assembly language.

### Project8 - Advanced VM Processing
Building upon the foundation set by Project7, Project8 introduces more advanced VM commands, including function calls, labels, and returns. It handles multiple .vm files in a directory, ensuring that the translated code is cohesive and functional.

### Project10 - Jack Tokenizer & Parser
This project is centered around tokenizing and parsing the high-level Jack programming language. It reads .jack files from a directory, tokenizes the content, and then parses the tokens to generate an intermediate representation.

### Project11 - XML to VM Translator
Project11 is designed to parse and process .xml files. It reads token files and processes them to generate output in the VM (Virtual Machine) format. This step is crucial in translating high-level Jack programs into VM commands.

### Game - Trivia Game in Jack
This is a trivia game developed in the Jack programming language. The game initializes and runs multiple levels, challenging the player's knowledge. It showcases the capabilities of the Jack language and the computer system built throughout the course.

## Usage:

1. Ensure the necessary tools and languages (like D and Jack) are set up on your machine.
2. Navigate to the respective project directory.
3. Execute the main file, typically providing the path to the directory containing the input files as an argument.
4. The program will process the input files and generate the required output.
