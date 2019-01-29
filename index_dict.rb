require 'byebug'
require 'yaml'
class IndexDict
    def initialize
        @reverse_mapping = YAML.load(File.read("reverse_mapping.yml"))
        @hash_indexing = {}
    end
    
    def create
        # Reading Data of Dictionary line by line
        IO.foreach("dictionary.txt") do |block|
            # puts "#{block}: #{block.length}"
            if(block.length > 3 && block.length < 12)
                block.delete!("\n")
                # Convert word to integers
                converted = convert(block.downcase)
                # puts "Converted: #{block} : #{converted}"
                # Index word in hash
                hash(block, converted)
            end            
        end
        # puts @hash_indexing
        File.open("index_dict.yml", "w+") do |file|
            file.write(@hash_indexing.to_yaml)
        end
    end

    private
    def hash(word, key)
        @hash_indexing[key[0..2]] = {} if @hash_indexing[key[0..2]].nil?
        @hash_indexing[key[0..2]][key] = [] if @hash_indexing[key[0..2]][key].nil?
        @hash_indexing[key[0..2]][key] << word.downcase
    end

    def convert(word)
        converted = word.split("").map{|a| @reverse_mapping[a] }.join("")
        # puts "Converted: #{converted}"
    end
end

indexing = IndexDict.new
indexing.create




