class BasicApi < Grape::API
  format :json

  content_type :txt, 'text/plain'

end
