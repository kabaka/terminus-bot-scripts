command 'build' do
  level! 10

  EM.system '/home/kabaka/scripts/update-repos.sh' do |output, s|
    case s.exitstatus
    when 0
      reply "Build completed. #{output}"
    else
      reply "Build failed. #{output}"
    end
  end
end

