event :PRIVMSG do
  unless @msg.connection.name == :ponychat and @msg.destination_canon == "#AUTISTIC-FAGGOTS"
    next
  end

  match = @msg.stripped.match(/(?<word>r+e+t+a+r+d+e+d+)/i)

  next unless match

  match = @msg.stripped.match(/\01ACTION (?<text>.+)\01/)

  if match
    text = match[:text].gsub(/(r+)(e+)(t+)(a+)(r+)(d+)(e+)(d+)/i, '\3\2\1\6\4\8\7')
    reply "* #{@msg.nick} #{text}", false
  else
    text = @msg.stripped.gsub(/(r+)(e+)(t+)(a+)(r+)(d+)(e+)(d+)/i, '\3\2\1\6\4\8\7')
    reply "<#{@msg.nick}> #{text}", false
  end

end
