class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home

  end

  def calculation
    uploaded_file = params[:file]

    file_content = uploaded_file.read

    sentences_num = sentences_count(file_content)
    words_num = word_count(file_content)
    syllables_num, histogram_data = syllabes_count

    #Formatting data to draw the histogram: Creating a hash with data values and frequency
    data_with_format =Hash[histogram_data.group_by{ |y| y }.map{|val,array| [val, array.size] }]
    #Geting % of frequence of number of Syllables per word
    percentage_data = Hash.new
    data_with_format.each do |key,value|
      
      percentage_data[key] = value * 100 / words_num.to_f
    end
    
    fi = 206.835 - 84.6 * (syllables_num/words_num.to_f) - 1.015 *(words_num/sentences_num.to_f)

    redirect_to action: 'graphic', fi: fi, syllables: syllables_num, words: words_num, sentences: sentences_num, data_with_format: data_with_format, percentage_data: percentage_data

  end

  def graphic
    @fi = params[:fi]
    @sentences = params[:sentences]
    @words = params[:words]
    @syllables = params[:syllables]


    @data_with_format = params[:data_with_format]
    @percentage_data = params[:percentage_data]
    
  end

  private

  def sentences_count(text)
    sentences = text.split(/[.?!]/)
    sentences.count
  end

  def word_count(text)
    @words = text.split(" ")
    @words.count
  end

  def syllabes_count
    #algorithm improved based on one part of this http://stackoverflow.com/a/5615724
    histogram_data = [] #At the end it will have the number of syllables of every word on the text (for drawing purposes)
    vowels = ["a", "e", "i", "o", "u", "y"] # Include "y" considered as semi vowel
    syllables = 0

    @words.each do |word|
      word_syllables = 0
      vowel_in_latest = false
      word.split("").each do |char|
        vowel_found = false
        vowels.each do |vowel|
          if char == vowel
            syllables += 1 unless vowel_in_latest
            word_syllables += 1 unless vowel_in_latest
            vowel_found = true
            vowel_in_latest = true
            break
          end
        end
        vowel_in_latest = false unless vowel_found
      end
      #remove 'es' ending and silent 'e'
      if word.length > 2 && word[-2..-1] == 'es'|| word.length > 1 && word[-1..-1] == 'e'
        syllables -= 1 
        word_syllables -= 1
      end
      
      histogram_data << word_syllables if word_syllables
    end
    [syllables, histogram_data]
  end
end
