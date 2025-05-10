class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def ransackable_associations(_auth_object = nil)
      @ransackable_associations ||= reflect_on_all_associations.map do |a|
        a.name.to_s
      end
    end

    def ransackable_attributes(_auth_object = nil)
      @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
    end
  end
end
