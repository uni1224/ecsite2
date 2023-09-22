class CartItem < ApplicationRecord
    belongs_to :customer
    belongs_to :item

    validates :amount, presence: true

    ## 小計を求めるメソッド
def subtotal
    item.tax_price * amount
end
end
