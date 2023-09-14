class Item < ApplicationRecord

has_one_attached :image
    # 消費税を含む金額
 def tax_price
   (price * 1.1).floor
 end

 def get_image(width, height)
  image.variant(resize_to_limit: [width, height]).processed
 end
end
