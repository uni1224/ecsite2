class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!
   before_action :set_current_customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, success: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def quit
  end

  def out
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
  end
end

