require 'nokogiri'
require 'open-uri'
# require 'google_drive'

# NB Now that the scapper file is based on a class, the rspec file doesn't work anymore (obsolete)
class Scrapper
  def get_data
    # Récupère la liste des villes et les convertit en URL, retourne 2 infos : Un tableau des URL, et un tableau avec le nom des villes
    def get_townhall_urls 
      city_list = []
      townhall_urls = []
      page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
      city_names = page.css('.lientxt')
      city_names.each do |city|
        townhall_urls.push "http://annuaire-des-mairies.com/95/#{city.text.downcase.gsub(/ /, '-')}.html"
        city_list.push city.text
      end
      [townhall_urls, city_list]
    end

    def get_townhall_email(url) # Convertit une URL de ville en l'adresse mail qui correspond
      page = Nokogiri::HTML(URI.open(url))
      mail = page.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
      mail.text
    end

    def townhall_infos_to_hash # Crée un hash en récupérant le tableau des villes, et en récupérant pour chaque ville l'email correspondant
      hash = {}
      # Le texte complet de 'lientxt' en downcase.
      tmp = get_townhall_urls
      townhall_list = get_townhall_urls[0]
      # Le nom des villes.
      city_names = get_townhall_urls[1]

      townhall_list.length.times do |i|
        hash[city_names[i]] = get_townhall_email(townhall_list[i])
      end
      hash
    end

    townhall_infos_to_hash
  end

  # Method source: https://stackoverflow.com/questions/5507512/how-to-write-to-a-json-file-in-the-correct-format/5507535#5507535
  def save_as_JSON(raw_data)
    File.open('db/emails.json', 'w') do |f|
      f.write(raw_data.to_json)
    end
  end

  # Source: https://stackoverflow.com/questions/2083570/possible-to-access-the-index-in-a-hash-each-loop
  def save_as_spreadsheet(raw_data)
    session = GoogleDrive::Session.from_config('db/config.json')
    ws = session.spreadsheet_by_key('1ycx7kI41K6XXSHVkO8ZgWW8WFGFw1mWBJBDFNsuwdGA').worksheets[0]
    raw_data.each_with_index do |(key, value), index|
      ws[index + 1, 1] = key
      ws[index + 1, 2] = value
    end
    ws.save
  end

  # Source: https://stackoverflow.com/questions/8183706/how-to-save-a-hash-into-a-csv
  def save_as_csv(raw_data)
    CSV.open('db/emails.csv', 'wb') { |csv| raw_data.each { |elem| csv << elem } }
  end
end
