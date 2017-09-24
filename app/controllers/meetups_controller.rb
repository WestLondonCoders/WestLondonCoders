class MeetupsController < ApplicationController
  before_action :get_meetup, except: :index

  def index
    request = RestClient.get "https://api.meetup.com/West-London-Coders/events?photo-host=public&page=5&sig_id=202775078&sig=7106b5f894f37222f896b703e3a9c6e95f5a65a4&key=#{ENV['MEETUP_KEY']}"
    @meetups = ActiveSupport::JSON.decode(request)
    unless @meetups.any?
      redirect_to 'https://www.meetup.com/preview/West-London-Coders/events'
    end
  end

  def badges
    @no_layout = true
  end

  private

  def get_meetup
    get_meetup = RestClient.get "https://api.meetup.com/West-london-coders/events/#{params[:id]}?&sign=true&photo-host=public&key=#{ENV['MEETUP_KEY']}"
    @meetup = ActiveSupport::JSON.decode(get_meetup)

    get_rsvps = RestClient.get "https://api.meetup.com/West-london-coders/events/#{params[:id]}/rsvps?&sign=true&photo-host=public&key=#{ENV['MEETUP_KEY']}"
    @members = ActiveSupport::JSON.decode(get_rsvps)

    @ynap = Sponsor.find_by(slug: 'yoox-net-a-porter')
  end
end
