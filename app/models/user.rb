class User < ApplicationRecord
    has_secure_password validations: false
    has_many :follows

    def follows
        Follow.where("followee_id = ? OR follower_id = ?", self.id, self.id)
    end

    def self.from_omniauth(response)
        User.find_or_create_by(provider: response[:provider]) do |u| attributes
            u.nick_name = response[:info][:name]
            u.email = response[:info][:email]
            u.password = SecureRandom.hex(15)
        end
    end

end
