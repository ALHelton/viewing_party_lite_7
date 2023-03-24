class Party < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :name, :party_date, :party_time, :user_id, :duration, presence: :true

  def list_invitees
    self.users.joins(:user_parties).where(user_parties: {party_id: self.id}).where(user_parties: {invite_status: "invited"}).distinct
  end
end