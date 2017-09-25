class MeetupsController < ApplicationController
  before_action :get_meetup, except: [:index, :past_meetups]

  def index
    @meetups = ActiveSupport::JSON.decode(get_upcoming_meetups)
    @last_six_past_meetups = ActiveSupport::JSON.decode(get_last_six_past_meetups)

    unless @meetups.any?
      redirect_to 'https://www.meetup.com/preview/West-London-Coders/events'
    end
  end

  def badges
    @no_layout = true
  end

  def past_meetups
    @all_past_meetups = ActiveSupport::JSON.decode(get_all_past_meetups)
  end

  private

  def get_meetup
    get_meetup = RestClient.get "https://api.meetup.com/West-london-coders/events/#{params[:id]}?&sign=true&photo-host=public&key=#{ENV['MEETUP_KEY']}"
    @meetup = ActiveSupport::JSON.decode(get_meetup)

    get_rsvps = RestClient.get "https://api.meetup.com/West-london-coders/events/#{params[:id]}/rsvps?&sign=true&photo-host=public&key=#{ENV['MEETUP_KEY']}"
    @members = ActiveSupport::JSON.decode(get_rsvps)

    @ynap = Sponsor.find_by(slug: 'yoox-net-a-porter')
  end

  def get_upcoming_meetups
    RestClient.get "https://api.meetup.com/West-London-Coders/events?photo-host=public&page=5&sig_id=202775078&sig=7106b5f894f37222f896b703e3a9c6e95f5a65a4&key=#{ENV['MEETUP_KEY']}"
  end

  def get_last_six_past_meetups
    RestClient.get "https://api.meetup.com/West-london-coders/events?desc=true&photo-host=public&page=6&sig_id=202775078&status=past&sig=d15e960c8637ee4a358560b3e4c16e04743b383b
&key=#{ENV['MEETUP_KEY']}"
  end

  def get_all_past_meetups
    RestClient.get "https://api.meetup.com/West-london-coders/events?desc=true&photo-host=public&page=100&sig_id=202775078&status=past&sig=d15e960c8637ee4a358560b3e4c16e04743b383b
&key=#{ENV['MEETUP_KEY']}"
  end
end
