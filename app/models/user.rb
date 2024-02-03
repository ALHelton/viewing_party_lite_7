class User < ApplicationRecord
  include Authority::UserAbilities

  has_many :user_parties
  has_many :parties, through: :user_parties

  def get_host_parties
    Party.where(user_id: id)
  end

  def invited_parties
    Party.joins(:user_parties).where(user_parties: {user_id: id}).where(user_parties: {invite_status: "invited"})
  end

  def self.find_host(user_id)
    find(user_id).name
  end
end
