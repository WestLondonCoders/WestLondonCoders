class MeetupsController < ApplicationController
  def index
    request = RestClient.get "https://api.meetup.com/West-London-Coders/events?photo-host=public&page=5&sig_id=202775078&sig=7106b5f894f37222f896b703e3a9c6e95f5a65a4&key=#{ENV['MEETUP_KEY']}"
    @meetups = ActiveSupport::JSON.decode(request)
    unless @meetups.any?
      redirect_to 'https://www.meetup.com/preview/West-London-Coders/events'
    end
  end
end
