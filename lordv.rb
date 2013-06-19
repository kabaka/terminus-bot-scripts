need_module! 'buffer'

require 'timeout'

register 'Indicate when you have been LordVed.'

event :PRIVMSG do
  next if query?

  # XXX - fix recognition of escaped slashes
  match = @msg.text.match(/^l\/(?<search>.+?)(\/(?<flags>.*))?$/)

  if match
    next unless Buffer.has_key? @connection.name
    next unless Buffer[@connection.name].has_key? @msg.destination

    grep match

    next
  end
end

helpers do
  def grep match
    Timeout::timeout(get_config(:run_time, 2).to_i) do
      # match[:replace] is flags because whatever
      search, flags, opts = match[:search], match[:flags], Regexp::EXTENDED

      opts |= Regexp::IGNORECASE if flags and flags.include? 'i'

      search = Regexp.new match[:search].gsub(/\s/, '\s'), opts

      Buffer[@connection.name][@msg.destination].reverse.each do |message|
        next if @connection.canonize(message[:nick]) == @msg.nick_canon
        next if message[:text].match(/^l\/(.+?)\/(.*?)(\/.*)?$/)

        if search.match message[:text]
          reply_with_match message[:type], message[:nick], message[:text]

          return
        end

      end
    end
  end

  def reply_with_match type, nick, message
    case type
    when :ACTION
      reply "#{@msg.nick} was LordVed on: * #{nick} #{message}", false
    when :PRIVMSG
      reply "#{@msg.nick} was LordVed on: <#{nick}> #{message}", false
    when :NOTICE
      reply "#{@msg.nick} was LordVed on: -#{nick}- #{message}", false
    end
  end
end

