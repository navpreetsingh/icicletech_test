require 'yaml'

def reverse_mapping
    number_mapping = {
        '2': 'abc',
        '3': 'def',
        '4': 'ghi',
        '5': 'jkl',
        '6': 'mno',
        '7': 'pqrs',
        '8': 'tuv',
        '9': 'wxyz'
    }
    alphabet_mapping = {}
    number_mapping.each do |key, value|
        value.split("").each do |alphabet|
            alphabet_mapping[alphabet] = key.to_s
        end
    end
    # puts alphabet_mapping
    
    # Writing Reverse Mapping in a File
    File.open("reverse_mapping.yml", "w+") do |file|
        file.write(alphabet_mapping.to_yaml)
    end

    # Writing Mapping in a File
    File.open("mapping.yml", "w+") do |file|
        file.write(number_mapping.to_yaml)
    end
end

reverse_mapping