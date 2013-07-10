need_module! 'regex_handler'

regex /r+e+t+a+r+d+e+d+/i do
  next unless @msg.connection.name   == :ponychat 
  next unless @msg.destination_canon == "#AUTISTIC-FAGGOTS"

  match = @msg.stripped.match(/\01ACTION (?<text>.+)\01/)

  if match
    reply "* #{@msg.nick} #{apply_substitutions match[:text]}", false
  else
    reply "<#{@msg.nick}> #{apply_substitutions @msg.stripped}", false
  end

end

helpers do
  def apply_substitutions text
    text.gsub  /(r+)(e+)(t+)(a+)(r+)(d+)(e+)(d+)/i, '\3\2\1\6\4\8\7'
  end
end

