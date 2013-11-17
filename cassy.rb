register 'Store and output Cassyisms.'

command 'cassy', 'Look up Cassy\'s definitions of terms. Syntax: RANDOM|ADD word definition|DELETE word' do
  argc! 1

  p = @params.first

  first_word, second_word, remainder = p.split(/\s/, 3)

  if remainder.nil?
    first_word.upcase!

    if first_word == 'RANDOM'

      word = get_all_data.keys.sample
      fact = get_data word

      reply "\02#{word}\02 is: #{fact}"

      next
    end

    unless second_word.nil?
      second_word.upcase!

      if first_word == 'DELETE'
        unless get_data second_word
          raise 'No such Cassy fact.'
        end

        delete_data second_word

        reply "Definition for #{second_word} has been deleted."

        next
      end
    end

  else
    first_word.upcase!
    second_word.upcase!

    if first_word == 'ADD'

      if get_data second_word
        raise "Definition for #{second_word} already exists."
      end

      store_data second_word, remainder

      reply "Definition for #{second_word} has been stored."

      next
    end
  end

  fact = get_data p.upcase

  if fact.nil?
    reply 'No such Cassy fact.'
    next
  end

  reply fact
end
