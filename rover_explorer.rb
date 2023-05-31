# This module contains all the basic and more general methods needed to navigate the rovers
module RoversNavigatorHelper
  VALID_ORIENTATION_REFERENCE = %w[N S E W].freeze
  VALID_INSTRUCTIONS = %w[L R M].freeze
  ROTATE_LEFT_MAPPING = { 'N' => 'W', 'W' => 'S', 'S' => 'E', 'E' => 'N' }.freeze
  ROTATE_RIGHT_MAPPING = { 'N' => 'E', 'E' => 'S', 'S' => 'W', 'W' => 'N' }.freeze
  def valid_orientation_set
    VALID_ORIENTATION_REFERENCE
  end

  def valid_instructions_set
    VALID_INSTRUCTIONS
  end

  def rotate_left(orientation)
    ROTATE_LEFT_MAPPING[orientation]
  end

  def rotate_right(orientation)
    ROTATE_RIGHT_MAPPING[orientation]
  end

  def move(coordinates, orientation, step = 1)
    coordinates_ary = coordinates.split(' ')
    case orientation
    when 'N'
      coordinates_ary[1] = (coordinates_ary[1].to_i + step).to_s
    when 'S'
      coordinates_ary[1] = (coordinates_ary[1].to_i - step).to_s
    when 'E'
      coordinates_ary[0] = (coordinates_ary[0].to_i + step).to_s
    when 'W'
      coordinates_ary[0] = (coordinates_ary[0].to_i - step).to_s
    else
      raise 'Invalid orientation. Check the input file'
    end
    coordinates_ary.join(' ')
  end

  def start_exploring
    instructions.each_line.to_a[1..].each_slice(2) do |position_and_instruction_set|
      position, instruction_set = position_and_instruction_set
      position = position.split(' ')
      coordinates = position[0..1].join(' ')
      orientation = position[2]
      instruction_set.split(' ').each do |instruction|
        case instruction
        when 'L'
          orientation = rotate_left(orientation)
        when 'R'
          orientation = rotate_right(orientation)
        when 'M'
          coordinates = move(coordinates, orientation)
        else
          raise 'Invalid instruction. Check the input file'
        end
      end
      puts "#{coordinates} #{orientation}"
    end
  end

  def valid_coordinates?(coordinates, allow_all_zeros: false)
    coordinates_ary = coordinates.split(' ')
    coordinates_ary.size == 2 &&
      coordinates_ary.all? { |coordinate| coordinate.to_i.to_s == coordinate } &&
      (coordinates_ary.any? { |coordinate| coordinate.to_i != 0 } | allow_all_zeros)
  end

  def valid_instructions?(instructions)
    instructions.each_line.to_a[1..].each_slice(2) do |position_and_instruction_set|
      position, instruction_set = position_and_instruction_set
      position = position.split(' ')
      coordinates = position[0..1].join(' ')
      orientation = position[2]
      unless valid_coordinates?(coordinates, allow_all_zeros: true)
        raise 'Position is not valid. It must be 2 integers separated by a space'
      end
      unless VALID_ORIENTATION_REFERENCE.include?(orientation)
        raise "Orientation is not valid. It must be one of these: #{VALID_ORIENTATION_REFERENCE}"
      end
      return false unless instruction_set.split(' ').all? { |instruction| VALID_INSTRUCTIONS.include?(instruction) }
    end
    true
  end

  def check_instructions(instructions)
    unless valid_coordinates?(instructions.each_line.first.chomp)
      raise 'Invalid coordinates. They must be 2 space separated integers and at least one of them different than zero'
    end
    return if valid_instructions?(instructions)

    raise "Invalid instructions. They must be space separated and can only be any of these: #{valid_instructions_set}"
  end

  def print_help
    help_menu = <<-HELPTEXT
    This is a program to explore a plateau on Mars with rovers
    The instructions must be in a file and the file path must be passed as an argument
    The first line of the file must be the coordinates of the upper-right corner of the plateau, the lower-left coordinates are assumed to be 0,0.
    The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input.
    The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.
    The position is made up of two integers and a letter separated by spaces, corresponding to the x and y coordinates and the rover's orientation.
    The orientation can be one of these: #{valid_orientation_set.join(', ')}   (North, South, East, West)
    Instructions set: #{valid_instructions_set.join(', ')}  (Left, Right, Move)
    To make the rovers start exploring, run the program with the file path as an argument
    File example:

    5 5
    1 2 N
    L M L M L M L M M
    3 3 E
    M M R M M R M R R M

    Output:

    1 3 N
    5 1 E
    HELPTEXT
    puts help_menu
  end
end

# This class contains the main logic of the program.
# You can customize the valid orientation reference set and
# the valid instructions set by overriding the module's methods and constants
class RoverExplorer
  VALID_ORIENTATION_REFERENCE = %w[N S E W].freeze
  include RoversNavigatorHelper

  attr_reader :instructions

  def initialize
    if ARGV.first == '-h'
      print_help
      exit
    end
    @instructions = File.read(ARGV.first)
    check_instructions(instructions)
  rescue
    print_help
  end
end

Sojourner = RoverExplorer.new
Sojourner.start_exploring
