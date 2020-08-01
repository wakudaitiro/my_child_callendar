class ProductsController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:keyword]
      @items= RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end
