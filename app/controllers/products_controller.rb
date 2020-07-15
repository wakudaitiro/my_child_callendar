class ProductsController < ApplicationController
  def index
  end

  def search
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      binding.pry
    end
  end
end
