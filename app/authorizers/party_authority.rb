class PartyAuthority < Authority::Authorizer

  def deletable_by?(user)
    require 'pry', binding.pry
    User.find(resource.user_id) == user || user.admin?
  end

end