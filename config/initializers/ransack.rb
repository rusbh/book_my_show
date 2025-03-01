Ransack.configure do |config|
  config.add_predicate(
    "array_contains",
    arel_predicate: "contains",
    formatter: proc { |v| "{#{v}}" },
    validator: proc { |v| v.present? },
    type: :string,
  )
end
