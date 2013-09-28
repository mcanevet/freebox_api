module FreeboxApi

  class Session

    def initialize(app, freebox)
      @app = app
      @freebox = freebox
    end

    def password
      Digest::HMAC.hexdigest(@freebox.challenge, @app[:app_token], Digest::SHA1)
    end

    def session_token
      @freebox.http_call('post', '/login/session/',
        {:app_id => @app[:app_id], :password => password}, nil)['session_token']
    end

    def http_call(http_method, path, params = {})
      @freebox.http_call(http_method, path, params, self)
    end

  end

end
