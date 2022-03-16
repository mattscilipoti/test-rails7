class ApplicationController < ActionController::Base
  def about
    about = {}
    about[:credentials] = Rails.application.credentials.config.sort.to_h
    about[:environment_variables] = ENV.sort.to_h

    # Removing filtering, since this is a sample app and this info may be helpful. Leaving the idea here in case we realise we need it.
    # @filtered_about = {}
    # about.each do |key, value| 
    #   if Rails.application.config.filter_parameters.any? {|filter_regex| key =~ Regexp.new(filter_regex.to_s) }
    #     @filtered_about[key] = "REDACTED"
    #   else
    #     @filtered_about[key] = value
    #   end
    # end
    
    @about = about
  end
end
