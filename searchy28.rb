

require 'nokogiri'
require 'open-uri'
require 'pry'


#url = "http://copac.ac.uk/search?au=Miller&ti=crucible&format=XML+-+MODS"
url = "http://www.worldcat.org/webservices/catalog/search/worldcat/opensearch?au=tolkein&ti=rings&wskey={built-in-api-key}"

doc = Nokogiri::XML(open(url))

doc.remove_namespaces!

locs=doc.xpath("//loc")
valid_locs=locs.select do |loc|
	held_by=loc["heldBy"]
	held_by=="British Library" || 
	held_by.match("Cambridge") ||
	held_by.match("Oxford") ||
	held_by.match("Edinburgh") ||			
	held_by.match("Glasgow") ||
	held_by.match("Manchester") ||
	held_by.match("Bodleian") || 
	
	held_by.match("National Library of Scotland") ||
	held_by.match("Arizona") ||


	held_by.match("Yale") ||
	held_by.match("Library of Congress") ||


	held_by.match("Harvard") ||
	held_by.match("Boston Public") ||


	held_by.match("New York Public") ||
	held_by.match("Columbia") ||
	held_by.match("New York University") ||
	held_by.match("Toronto Public")




end




File.open("exported15.txt","w") do |file|
	library_list = valid_locs.map do |loc|
		loc["heldBy"] 
 	end.uniq


 
  	file.puts library_list
 
    
end






