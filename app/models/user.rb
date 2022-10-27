class User < ApplicationRecord
    before_save { email.downcase! }

    VALID_EMAIL_REGREX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
    
    has_many :microposts
    has_secure_password

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { minimum: 20, maximum: 255 }, format: { with: VALID_EMAIL_REGREX }, uniqueness:{ case_sensitive: false }
    validates :password, presence: true, length: { minimum:8 }
    
end