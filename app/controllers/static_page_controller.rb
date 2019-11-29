class StaticPageController < ApplicationController

  def index
    @recommend = Item.where("").order(Arel.sql("random()")).limit(1)[0]
  end
end
