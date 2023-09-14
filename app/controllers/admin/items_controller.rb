class Admin::ItemsController < ApplicationController

    def new
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
        if @item.save
            flash[:success] = '商品を追加しました'
            redirect_to admin_item_path(@item)
        else
            render :new
        end
    end

    def index
        @items = Item.all
    end

    def show
        @item = Item.find(params[:id])
    end

  private
  def item_params
      params.require(:item).permit(:name, :description, :image, :genre_id, :price, :is_selled)
  end

end
