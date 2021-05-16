class Book < ApplicationRecord
  
  with_options presence: true do
    validates :title
    validates :body
  end
  validates :body, length: {maximum: 200}
  belongs_to :user
end
