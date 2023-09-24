class Address < ApplicationRecord
    
    belongs_to :customer
    validates :address, presence: true
    validates :postal_code, presence: true,numericality: {omly_integer: true}, length: { is:7 }
    validates :name, presence: true
    
    #セレクトボタン内に１行でまとめて表示させるためのメゾット
    def address_display
        '〒' + postal_code + ' ' + address + ' ' + name
    end
end
