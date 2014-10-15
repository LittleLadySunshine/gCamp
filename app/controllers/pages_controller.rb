class PagesController <ApplicationController

  def index


    quote1 = Quote.new
    quote1.text = '"Keep your eyes on the stars, and your feet on the ground."'
    quote1.author = "Theodore Roosevelt"

    quote2 = Quote.new
    quote2.text = '"Start where you are. Use what you have. Do what you can."'
    quote2.author = "Arthur Ashe"

    quote3 = Quote.new
    quote3.text = '"A creative man is motivated by the desire to achieve, not by the desire to beat others."'
    quote3.author = "Ayn Rand"

  @quotes = [quote1, quote2, quote3]
  end

end
