register 'Store and output Cassyisms.'

command 'cassy', 'Look up Cassy\'s definitions of terms. Syntax: word|RANDOM|ADD word definition|DELETE word|STATS|LIST' do
  argc! 1

  params = @params.first

  first_word, second_word, remainder = params.split(/\s/, 3)

  case first_word.downcase
  when 'random'
    display_cassyism
  when 'stats'
    reply "There are \002#{get_all_data.length}\002 definitions in the databsae."
  when 'list'
    reply get_all_data.keys.join ', '
  when 'delete'
    argc! 2, 'DELETE word'

    delete_cassyism second_word

    reply "Definition for #{second_word} has been deleted."

  when 'add'
    argc! 3, 'ADD word definition'

    add_cassyism second_word, remainder

    reply "Definition for #{second_word} has been stored."
  else
    display_cassyism params
  end
end

helpers do
  def display_cassyism word = nil
    if word.nil?
      word = get_all_data.keys.sample

      if word.nil?
        raise 'No Cassyisms available.'
      end

      definition = get_data word
    else
      definition = get_cassyism word
    end

    actually_display_cassyism word, definition
  end

  def get_cassyism word
    definition = get_data word.downcase

    raise 'No such Cassyism.' if definition.nil?
  end

  def actually_display_cassyism word, definition
    reply "\002#{word}\002 is #{definition}"
  end

  def delete_cassyism word
    word.downcase!

    unless get_data word
      raise 'No such Cassyism.'
    end

    delete_data word
  end

  def add_cassyism word, definition
    if get_data word.downcase
      raise "Definition for #{word} already exists."
    end

    store_data word.downcase, definition
  end
end

