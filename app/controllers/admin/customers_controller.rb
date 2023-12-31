class Admin::CustomersController < ApplicationController
    def show
        @customer = Customer.find(params[:id])
    end

    def index
        @customers = Customer.all
    end

    def edit
        @customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])
        if customer.update(customer_params)
            flash[:success] = '会員情報の変更に成功しました'
            redirect_to admin_customer_path(@customer.id)
        else
            flash.now[:danger] = '会員情報の変更ができませんでした'
            render :edit
        end
    end

    private

    def customer_params
        params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
    end
end
