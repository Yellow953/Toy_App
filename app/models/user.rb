class User < ApplicationRecord
    before_save { email.downcase! }

    attr_accessor :remember_token

    VALID_EMAIL_REGREX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
    
    has_many :microposts
    has_secure_password

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { minimum: 10, maximum: 255 }, format: { with: VALID_EMAIL_REGREX }, uniqueness:{ case_sensitive: false }
    validates :password, presence: true, length: { minimum:8 }, allow_nil: true
    
    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
        
        def new_token
            SecureRandom.urlsafe_base64
        end
    end


    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated? (remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remeber_digest).is_password?(remember_token)
    end
    
    def forget
        update_attribute(:remember_digest, nil)
    end
    
end