#!/usr/bin/env ruby
LEVEL_PATH = "./Assets/Tiled/"

# the command that will build the level
COMMAND = "mono ./Tools/Tiled2Unity/Tiled2Unity.exe -s 1 -c Assets/Tiled/%s.tmx ./" # the -c flag means run in console mode (headless)

def get_levels
  Dir.glob( LEVEL_PATH + "*.tmx" ).map { |x| x.gsub(".tmx", '').gsub(LEVEL_PATH, '').strip }
end

def convert_level level
  puts "converting level: #{level}"
  
  cmd = COMMAND % level
  `#{cmd}`

  puts ""
end

# levels available
levels = get_levels

# handle user input
level = ARGV[0]
if level == '--gui'
  `mono ./Tools/Tiled2Unity/Tiled2Unity.exe`
elsif level == "all"
  levels.each { |level| convert_level( level ) }
elsif !levels.include? level
  # print usage statement
  puts "usage:"
  puts 'ruby ' + __FILE__ + " [--gui] all|level" 
  puts ""
  puts "levels:"
  levels.each { |x| puts " - #{x}" }
  puts( '-- no levels available. Added tiled levels to ' + LEVEL_PATH) if levels.size == 0
  puts ""
else
  convert_level level
end