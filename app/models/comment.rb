class Comment < ApplicationRecord

  belongs_to :commentable, polymorphic: true

  validates :title, :body, { presence: true }

end
