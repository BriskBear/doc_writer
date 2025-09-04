require 'yaml'

@config = YAML.load_file('config.yml')

PATH = {
  out:   @config[:title].gsub(/\s/,'_').downcase + '.html',
  md:    'md',
  stubs: 'lib/stubs'
}

PATH[:body]       = PATH[:md]    + '/body.md'
PATH[:intro]      = PATH[:md]    + '/intro.md'
PATH[:header]     = PATH[:stubs] + '/header.html'
PATH[:letterhead] = PATH[:stubs] + '/letterhead.html.erb'
PATH[:struct]     = PATH[:stubs] + '/struct.md.erb'

def current?
  files = Dir.glob("**/*")

  %i[header letterhead struct stubs].each{|p| files.include?(PATH[p]) || puts("#{PATH[p]} not found")}

  true
end
