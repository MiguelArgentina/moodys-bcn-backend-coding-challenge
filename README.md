![](https://img.shields.io/badge/Coding-Challenge-red)
## Coding Problem

A squad of robotic rovers are to be landed by NASA on a plateau on Mars. This plateau, which is curiously rectangular, must be navigated by the rovers so that their on-board cameras can get a complete view of the surrounding terrain to send back to Earth. A rover's position and location is represented by a combination of x and y co- ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation.

An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.

In order to control a rover, NASA sends a simple string of letters. The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot. 'M' means move forward one grid point, and maintain the same Heading.

Assume that the square directly North from (x, y) is (x, y+1).

### INPUT
The first line of input is the upper-right coordinates of the plateau, the lower- left coordinates are assumed to be 0,0. The rest of the input is information pertaining to the rovers that have been deployed.

Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.

The position is made up of two integers and a letter separated by spaces, corresponding to the x and y coordinates and the rover's orientation.

Each rover will be finished sequentially, which means that the second rover won't start to move until the first one has finished moving.

### OUTPUT
The output for each rover should be its final co-ordinates and heading.
EXAMPLE: INPUT AND OUTPUT

Test Input:
5 5
1 2 N
L M L M L M L M M
3 3 E
M M R M M R M R R M

Expected Output:
1 3 N
5 1 E

s-bcn-backend-coding-challenge

### Prerequisites
- ruby 2.7.6

### How to run the project
- Clone the project with `git clone git@github.com:MiguelArgentina/moodys-bcn-backend-coding-challenge.git`
- cd into the project's directory
- run `ruby rover_explorer.rb -h` for the help menu
- run `ruby rover_explorer.rb navigation_instructions.txt` to make the rovers explore the plateau

## Author


### Miguel Gomez

<img width="100" alt="Miguel Gomez Profile Picture" src="https://avatars.githubusercontent.com/u/50305489?s=400&u=2d451ca03611a85431ac4e851ab7a4fc3425bb7d&v=4">


* GitHub: [MiguelArgentina](https://github.com/MiguelArgentina)
* twitter - [Qete_arg](https://twitter.com/Qete_arg)
* LinkedIn: [Miguel Ricardo Gomez](https://www.linkedin.com/in/miguelricardogomez/)
