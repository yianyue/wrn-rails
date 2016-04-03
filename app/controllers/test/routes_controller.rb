class Test::RoutesController < ApplicationController

  def index
    @routes = []
    Rails.application.routes.routes.each do |route|
      # byebug
      path = route.path.spec.to_s.split('(').first
      method = route.verb.source.to_s.gsub("^","").gsub("$","")
      @routes << Route.new(path: path, method: method) if path.start_with?('/api') && !method.include?('PATCH')
    end
    @routes
  end

  # protected
  #
  # def entry_params
  #   params.require(:entry).permit(:content)
  # end

end
