class User < ApplicationRecord
  include PgSearch::Model
  after_create :notify_creation
  after_destroy :notify_destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true


  def notify_creation
    SlackNotifier::CLIENT.ping "🎉 Gente nova na equipe: #{nome} | #{email} 🎉"
  end

  def notify_destroy
    SlackNotifier::CLIENT.ping "#{nome} | #{email} está deixando a nossa equipe."
  end

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
