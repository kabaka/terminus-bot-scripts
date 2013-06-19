event :PRIVMSG do
  unless @msg.connection.name == :ponychat and @msg.destination_canon == "#AUTISTIC-FAGGOTS"
    next
  end

  match = @msg.stripped.match(/(?<word>the cloud)/i)

  next unless match

  match = @msg.stripped.match(/\01ACTION (?<text>.+)\01/)

  if match
    text = match[:text].gsub(/the cloud/i, 'my butt')
    reply "* #{@msg.nick} #{text}", false
  else
    text = @msg.stripped.gsub(/the cloud/i, 'my butt')
    reply "<#{@msg.nick}> #{text}", false
  end

end
