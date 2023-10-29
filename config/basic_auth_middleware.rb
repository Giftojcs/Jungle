class BasicAuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    auth = Rack::Auth::Basic::Request.new(env)
    if auth.provided? && auth.basic? && auth.credentials &&
       auth.credentials[0] == ENV['BASIC_AUTH_USERNAME'] &&
       auth.credentials[1] == ENV['BASIC_AUTH_PASSWORD']
      @app.call(env)
    else
      unauthorized
    end
  end

  private

  def unauthorized
    [401, { 'WWW-Authenticate' => 'Basic realm="Restricted Area"' }, ['Unauthorized']]
  end
end