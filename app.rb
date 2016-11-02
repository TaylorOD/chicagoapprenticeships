require 'sinatra'
require 'json'

get '/' do
  erb :index, locals: { programs: programs }
end

def programs
  data = File.read('./apprenticeships.json')
  JSON.parse(data)
end

helpers do
  def search_tags(program)
    program = program.dup
    program.delete("image_url")
    program["benefit_tag"] = "with benefits" if program["benefits"] == "Yes"
    program["mentor_tag"] = "mentor program" if program["mentor_buddy"] == "Yes"

    program.values.join(" ").downcase.gsub(/[^a-zA-Z0-9 ]+/, ' ')
  end
end