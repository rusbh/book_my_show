class LogsComponent < ApplicationComponent
  attr_reader :logs, :title, :pagy

  def initialize(logs:, title:, pagy:)
    @logs = logs
    @title = title
    @pagy = pagy
  end
end
