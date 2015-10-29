at_exit {puts "Bye-Bye! See you again"}

class FileFormatLister
  @@actions = [(lambda { exit })]

  def self.get_format_files
    @@files = Array.new
    Dir[File.join(__dir__, 'FileGenerators', '*.rb')].each do |file|
      load file
      class_name = File.basename(file, '.rb')
      klass = Object.const_get(class_name)
      @@files << class_name if (klass.methods(false) + klass.instance_methods - Object.methods - Object.instance_methods).include?(:write_to_file)
    end
  end

  def self.get_valid_formats
    @@valid_formats = Array.new
    @@files.each do |format|
      format.match(/Gen/) {|m| @@valid_formats << m.pre_match}
    end
  end

  def self.print_valid_formats
    unless @@valid_formats.count == 0
      @@valid_formats.each_with_index {|format, i| puts"#{i+=1}. #{format}"}
    else
      puts 'No formats available'
    end
  end
  
  def self.define_actions(user_hash)
    @@valid_formats.each do |format|
      action = lambda {
        klass = Object.const_get(format+"Gen")
        klass.instance_methods.include?(:write_to_file) ? obj = klass.new : obj = klass
        obj.write_to_file(user_hash)
        puts "Written successfully to file: #{File.join(__dir__, 'Resume')}.#{format.downcase}"
      }
      @@actions << action
    end
  end
  
  def self.make_choice(choice)
    while !((0..@@valid_formats.count).include?choice)
      puts "Wrong choice! Enter a choice again"
      choice = gets.to_i
    end
    @@actions[choice].call
  end

  def self.list_formats
    self.get_valid_formats
    self.print_valid_formats
    puts "Enter a choice. Press '0' to exit."
  end

  def self.output_file(user_hash)
    self.define_actions(user_hash)
    choice = gets.to_i
    self.make_choice(choice)
  end
end
