class Public::OrdersController < ApplicationController
    
    def new
        @cart_items = current_customer.cart_items
        if @cart_items.any?
            @order = Order.new
            @addresses = current_customer.addresses
        else
            redirect_to cart_items_path
        end
    end
    
    def create
        @order = Order.new(oredr_params)
        if @order.save
            current_customer.cart_items.each do |cart_item|
                order_detail = OrderDetail.new()
                order_detail.order_id = @order.id
                order_detail.item_id = cart_item.item_id
                order_detail.quantity = cart_item.amount
                order_detail.subprice = cart_item.item.tax_price
                order_detail.save
            end
            current_customer.cart_items.destroy_all
            redirect_to thanks_orders_path
        end
    end
    
    def confirm
    end
    
    def index
        @orders = current_customer.orders.all
    end
    
    def show
        @order = Order.find_(params[:id])
        @total = @order.order_details.inject(0) {
            |sum, order_detail| sum + order_detail.total_price }
    end
    
    def thanks
    end
    
    def order_params
        params.require(:order).permit(:customer_id, :name, :address1, :postal_code, :billing_amount, :payment_method, :order_status)
    end
end
