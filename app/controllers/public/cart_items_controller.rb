class Public::CartItemsController < ApplicationController

    def index
        @cart_items = current_customer.cart_items
        @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    end

    def create
        @cart_item = CartItem.new(cart_item_params)
        #カートに商品を追加するときに同じ商品が入っていた場合
        if current_customer.cart_items.find_by(item_id: @cart_item.item_id)
            cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
            #数量を加算
            cart_item.amount += @cart_item.amount.to_i
            cart_item.save
            redirect_to cart_items_path
            #同じ商品がない場合そのまま保存
        else
            @cart_item.save
            redirect_to cart_items_path
        end
    end

    def update
        @cart_item = CartItem.find(params[:id])
        @cart_item.update(cart_item_params)
        redirect_to cart_items_path
    end

    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        redirect_to cart_items_path
    end

    def destroy_all
        current_customer.cart_items.destroy_all
        redirect_to cart_items_path
    end



    private
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :amount, :customer_id)
    end
end
