need_module! 'http'

require 'rexml/document'

command 'af' do
  uri = URI('http://radio.autistic-faggots.net/radio.ogg.xspf')

  http_get(uri) do |http|
    root = REXML::Document.new http.response

    root = root.elements['//playlist/trackList/track']
    
    artist = root.elements['//track/creator']
    track  = root.elements['//track/title']

    buf = []

    buf << artist.text  if artist
    buf << track.text   if track

    str = "#{buf.join(' - ')} :: tune in at http://autistic-faggots.net/radio"

    reply_without_prefix 'Now playing on #autistic-faggots radio' => str

  end
end
