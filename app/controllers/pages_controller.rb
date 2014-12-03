class PagesController < MarketingController

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



  def faqs

    question1 = Faq.new
    question1.text = "What is gCamp?"
    question1.answer = "gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks and documents. You'll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool."

    question2 = Faq.new
    question2.text = "How do I join gCamp?"
    question2.answer = "Right now, gCamp is still in production. So, so there is not a sign up page open to the public, yet! Your best option is to become super best friends with a gCamp developer. They can be found hanging around gSchool during the day and hitting the hottest clubs at night."

    question3 = Faq.new
    question3.text = "When will gCamp be finished?"
    question3.answer = "gCamp is a work in progress. That being said, it should be fully functional by December 2014. Functional, but our developers are going to continue to improve the sight for the foreseeable future. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is only (well, will only) be a click away. Amazing!"

    @faqs = [question1, question2, question3]
  end
end
