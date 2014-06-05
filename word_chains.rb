class WordChainer
  def initialize(dictionary_file_name)
    arr = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = {}
    arr.each do |a|
      @dictionary[a] = true
    end
  end
  
  def adjacent_words(word)
    new_dict = @dictionary.select {|d_word, _| d_word.length == word.length }
    new_dict.delete(word)
    
    new_dict.select! do |d_word, _|
      wrong_count = 0
      (0...word.length).each do |i|
        wrong_count += 1 unless word[i] == d_word[i]
      end
      
      wrong_count == 1
    end
    
    new_dict.keys
  end
  
  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    
    until @current_words.empty? || @all_seen_words.include?(target)      
      @current_words = explore_current_wrods      
    end
    
    build_path(target)
  end
  
  def explore_current_wrods
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.has_key?(adjacent_word)
        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end
    
    # new_current_words.each do |ncw|
    #   p "#{ncw}: #{@all_seen_words[ncw]}"
    # end
    new_current_words
  end
  
  def build_path(target)
    path = [target]
    until path[-1].nil?
      path << @all_seen_words[path[-1]]
    end
    
    path.pop
    if path[-1] == target
      "There is no path! Alas! Alack!"
    else
      path
    end
  end
  
end

p WordChainer.new("dictionary.txt").run("market", "reader")