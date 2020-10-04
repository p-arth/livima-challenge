class User < ApplicationRecord
  include PgSearch::Model
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true

  pg_search_scope :search_by_nome,
    against: [ :nome ],
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_by_email,
    against: [ :email ],
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_by_cargo,
    against: [ :cargo ],
    using: {
      tsearch: { prefix: true }
    }
  
end
