class UserParty < ApplicationRecord
  belongs_to :party
  belongs_to :user

  enum invite_status: {invited: 0, accepted: 1, rejected: 2}
end
