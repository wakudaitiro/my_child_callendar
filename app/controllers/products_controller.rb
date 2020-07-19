class ProductsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def search
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end
