class RootController < ApplicationController
  skip_before_action :authorize!

  def index
    render json: { message: quote }
  end

  def quote
    # '“” – ',
    [
      '“First, solve the problem. Then, write the code.” – John Johnson',
      '“Any fool can write code that a computer can understand. Good programmers write code that humans can understand.” – John Johnson',
      '“One of my most productive days was throwing away 1,000 lines of code.” – Ken Thompson',
      '“It is not enough for code to work.” – Robert C. Martin',
      '“A long descriptive name is better than a short enigmatic name. A long descriptive name is better than a long descriptive comment.” – Robert C. Martin',
      '“The best way to predict the future is to invent it.” – Alan Kay',
      '“Most good programmers do programming not because they expect to get paid or get adulation by the public, but because it is fun to program.” – Linus Torvalds',
      '“Measuring programming progress by lines of code is like measuring aircraft building progress by weight.” – Bill Gates',
      '“Good design adds value faster than it adds cost.” – Thomas C. Gale',
    ].sample
  end
end
