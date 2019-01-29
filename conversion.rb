require 'byebug'
require 'yaml'
class Conversion
    def initialize(number)
        @number = number.to_s
        @index_dict = YAML.load(File.read("index_dict.yml"))
    end

    def result
        if(@number.length < 10)
            nil
        else
            fetch(@number) 
        end
    end

    private 
        def fetch(number)
            initials = number[0..2]
            length = number.length - 1
            array = Array(2..length-3)
            array << length if length > 1
            array = array.reverse
            output = []
            hash = @index_dict[initials]
            array.each do |arr|
                # puts "Array: #{arr+1}"
                temp_output = hash[number[0..arr]]
                # puts ("Number: #{number[0..arr]}  Temp_Output: #{temp_output}")
                if number[arr+1].nil?
                    begin
                        output.push temp_output unless temp_output.nil?
                    rescue Exception => e
                        puts "Exception Message: #{e.message}"
                        puts "Exception Trace: #{e.backtrace.inspect  }"
                    end
                elsif !temp_output.nil?
                    new_temp_output = fetch(number[arr+1..length])
                    unless new_temp_output.nil?
                        # puts "New Temp Output: #{new_temp_output}"
                        temp_output = mixin(temp_output, new_temp_output) 
                        # puts "Temp Output: #{temp_output}"
                        begin
                            output = output + temp_output
                        rescue Exception => e
                            puts "Exception Message: #{e.message}"
                            puts "Exception Trace: #{e.backtrace.inspect  }"
                        end
                        
                    end
                end            
            end
            # output.compact!
            # puts ("Number: #{number} Output: #{output}")
            output.length > 0 ? output : nil
        end

        def mixin(array_1, array_2)
            mixin_output = []
            begin
                array_1.each do |arr_1|
                    array_2.each do |arr_2|
                        arr_2.each do |a2|
                            mixin_output << [arr_1, a2].flatten
                        end     
                    end
                end
                # puts "Array_1: #{array_1}, Array_2: #{array_2}, Mixin output: #{mixin_output}"
                mixin_output
            rescue Exception => e
                puts "Exception Message: #{e.message}"
                puts "Exception Trace: #{e.backtrace.inspect  }"
            end
        end
end

numbers = [6686787825, 2282668687]
input_numbers = ARGV
numbers = numbers + input_numbers

numbers.each do |number|
    t1 = Time.now
    conversion = Conversion.new(number)
    puts number
    result = conversion.result
    puts "Time Taken: #{Time.now - t1}"
    puts "Number: #{number} \n Final Result: #{result}"
end


