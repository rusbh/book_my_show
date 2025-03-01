module FriendlyIdModelMonkeyPatch
  def to_param
    if caller.to_s.include?("active_admin")
      id&.to_s
    else
      super
    end
  end
end

module FriendlyId
  module Model
    prepend FriendlyIdModelMonkeyPatch
  end
end
