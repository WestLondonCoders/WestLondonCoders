module ControllerSupport
  def login_as(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def expect_authorization_of(action, resource)
    controller.instance_variable_set(:@_authorized, true)
    expect(controller).to receive(:authorize!).with(action, resource)
  end

  def stub_uploaded_file(name, content_type)
    path = Rails.root.join('spec', 'support', name)
    Rack::Test::UploadedFile.new(path, content_type).tap do |image|
      allow(image).to receive(:duplicable?).and_return(false)
    end
  end

  [:get, :post, :put, :patch, :delete].each do |http_method|
    define_method(http_method) do |action, *args|
      xhr = args[0][:xhr] if args[0].respond_to?(:keys)
      args = format_args(args)

      if xhr
        xml_http_request(http_method, action, *args)
      else
        super action, *args
      end
    end
  end

  def xhr(request_method, action, parameters = nil, session = nil, flash = nil)
    ActiveSupport::Deprecation.warn(<<-MSG.strip_heredoc)
      xhr and xml_http_request methods are deprecated in favor of
      `get :index, xhr: true` and `post :create, xhr: true`
    MSG

    @request.env['HTTP_X_REQUESTED_WITH'] = 'XMLHttpRequest'
    @request.env['HTTP_ACCEPT'] ||= [Mime::JS, Mime::HTML, Mime::XML, 'text/xml', Mime::ALL].join(', ')
    method(request_method).super_method.call(action, parameters, session, flash).tap do
      @request.env.delete 'HTTP_X_REQUESTED_WITH'
      @request.env.delete 'HTTP_ACCEPT'
    end
  end

  def xml_http_request(request_method, action, parameters = nil, session = nil, flash = nil)
    @request.env['HTTP_X_REQUESTED_WITH'] = 'XMLHttpRequest'
    @request.env['HTTP_ACCEPT'] ||= [Mime::JS, Mime::HTML, Mime::XML, 'text/xml', Mime::ALL].join(', ')
    method(request_method).super_method.call(action, parameters, session, flash).tap do
      @request.env.delete 'HTTP_X_REQUESTED_WITH'
      @request.env.delete 'HTTP_ACCEPT'
    end
  end

  REQUEST_KWARGS = %i(params session flash xhr)
  def kwarg_request?(args)
    args[0].respond_to?(:keys) && (
      (args[0].key?(:format) && args[0].keys.size == 1) ||
      args[0].keys.any? { |k| REQUEST_KWARGS.include?(k) }
    )
  end

  def format_args(args) # rubocop:disable Metrics/MethodLength
    if args.empty?
      args
    elsif kwarg_request?(args)
      args = args[0]
      [extract_format(args), args[:session], args[:flash]]
    else
      ActiveSupport::Deprecation.warn(<<-MSG.strip_heredoc, caller(2))
        ActionController::TestCase HTTP request methods will only accept
        keyword arguments in future Rails versions.

        examples:
        `get :show, params: { id: 1 }, session: { user_id: 1 }`
        `process :update, method: :post, params: { id: 1 }`
      MSG

      args
    end
  end

  def extract_format(args)
    parameters = args[:params]

    if args[:format]
      if parameters
        parameters.merge!(Hash[*args.assoc(:format)])
      else
        parameters = Hash[*args.assoc(:format)]
      end
    end

    parameters
  end

  module ClassMethods
    ACTION_METHODS = { create: :post, destroy: :delete, update: :patch }

    def describe_action(name, method: :get, &block)
      http_method = ACTION_METHODS[name.to_sym] || method
      describe "#{http_method.upcase} ##{name}" do
        instance_eval(&block)
      end
    end

    def as_an_admin(&block)
      context "as an admin" do
        let(:admin) { FactoryGirl.create(:admin) }

        before do
          login_as admin
        end

        instance_eval(&block)
      end
    end
  end

  RSpec.configure do |config|
    config.include self, type: :controller
    config.extend ClassMethods, type: :controller
  end
end
