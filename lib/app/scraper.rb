require 'nokogiri'
require 'open-uri'

def get_townhall_urls # Récupère la liste des villes et les convertit en URL, retourne 2 infos : Un tableau des URL, et un tableau avec le nom des villes
  city_list = []
  townhall_urls = []
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  city_names = page.css('.lientxt')
  city_names.each do |city|
    townhall_urls.push "http://annuaire-des-mairies.com/95/#{city.text.downcase.gsub(/ /, '-')}.html" 
    city_list.push city.text
  end
  return townhall_urls, city_list
end

def get_townhall_email(url) # Convertit une URL de ville en l'adresse mail qui correspond
  page = Nokogiri::HTML(URI.open(url))
  mail = page.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  return mail.text
end

def townhall_infos_to_hash() #Crée un hash en récupérant le tableau des villes, et en récupérant pour chaque ville l'email correspondant
  hash = []
  # Le texte complet de 'lientxt' en downcase.
  townhall_list = get_townhall_urls[0]
  # Le nom des villes. 
  city_names = get_townhall_urls[1]

  townhall_list.length.times do |i|
    hash[i] = {city_names[i] => get_townhall_email(townhall_list[i])}
  end
  return hash
end

print townhall_infos_to_hash() #Affiche le hash
