class Item < ApplicationRecord

has_one_attached :image
has_many :cart_items, dependent: :destroy
belongs_to :genre
validates :name, presence: true
 validates :description, presence: true
 validates :image, presence: true
 validates :genre_id, presence: true
 validates :price, presence: true
enum is_selled: { sold_out: false, sale: true }
    # 消費税を含む金額
 def tax_price
   (price * 1.1).floor
 end

 def get_image(width, height)
  image.variant(resize_to_limit: [width, height]).processed
 end
end
