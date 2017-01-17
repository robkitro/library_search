

require 'nokogiri'
require 'open-uri'
require 'pry'


url = "http://copac.ac.uk/search?au=Scott&ti=Ivanhoe&format=XML+-+MODS"


doc = Nokogiri::XML(open(url))

doc.remove_namespaces!


#libraries = ["Edinburgh", "Oxford", "British Library"]
libraries = ["British Library", "Cambridge", "Oxford","Edinburgh","Glasgow","Manchester","Bodleian","National Library of Scotland"]

locs=doc.xpath("//loc")
valid_locs=locs.select do |loc|
	held_by=loc["heldBy"]
	libraries.any? do |lib|
		held_by.match(lib)
	end	
end


File.open("exported19.txt","w") do |file|
	library_list = valid_locs.map do |loc|
		loc["heldBy"] 
 	end.uniq
 
  	file.puts library_list
 
    
end






