module Owner
  class << self
    def name
      credentials.name!
    end

    def email
      credentials.email!
    end

    def credentials
      Rails.application.credentials.owner!
    end
  end
end
