class BasicApi < Grape::API
  format :json

  content_type :txt, 'text/plain'

  mount Basic::MembersApi => '/members'
  mount Basic::HackroomsApi => '/hackrooms'
  mount Basic::LanguagesApi => '/languages'
end
