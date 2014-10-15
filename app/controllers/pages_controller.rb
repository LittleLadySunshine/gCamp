class PagesController <ApplicationController

  def index
    @quotes = [
      ['"Keep your eyes on the stars, and your feet on the ground."', "Theodore Roosevelt"],
      ['"Start where you are. Use what you have. Do what you can."', "Arthur Ashe"],
      ['"A creative man is motivated by the desire to achieve, not by the desire to beat others."',"Ayn Rand"]
]
  end

end
