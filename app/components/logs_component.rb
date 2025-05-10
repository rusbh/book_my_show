class LogsComponent < ApplicationComponent
  attr_reader :logs, :title

  renders_one :pagination

  def initialize(logs:, title:)
    @logs = logs
    @title = title
  end
end
