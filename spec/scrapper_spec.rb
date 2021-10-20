require_relative '../lib/app/scrapper'

describe "getting mail address with city url" do
  it "should return the mail address matching the city Goussainville" do
    expect(get_townhall_email("http://annuaire-des-mairies.com/95/goussainville.html")).to eq("maire@ville-goussainville.fr")
  end

  it "should return the mail address matching cities having spaces in it" do
    expect(get_townhall_email("http://annuaire-des-mairies.com/95/la-chapelle-en-vexin.html")).to eq("la-chapelle-en-vexin@wanadoo.fr")
  end
end

describe "getting array with all informations" do
  it "should return the array containing 185 urls " do
    expect(get_townhall_urls[0].length).to eq(185)
  end

  it "should return the array containing 185 cities names " do
    expect(get_townhall_urls[1].length).to eq(185)
  end

  it "should return both arrays" do
    expect(get_townhall_urls.length).to eq(2)
  end
end
