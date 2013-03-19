require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Oschina < OmniAuth::Strategies::OAuth2
      option :client_options, {
          :site => 'http://www.oschina.net',
          :authorize_url => 'http://www.oschina.net/action/oauth2/authorize',
          :token_url => 'http://www.oschina.net/action/oauth2/token',
          :profile_url => 'http://www.oschina.net/action/oauth2/user'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
              # to support omniauth-oauth2's auto csrf protection
              session['omniauth.state'] = params[:state] if v == 'state'
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
            'nickname' => raw_info['name'],
            'email' => email,
            'name' => raw_info['name'],
            'image' => raw_info['avatar_url'],
            'urls' => {
                'Blog' => raw_info['url'],
            },
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
	access_token.options[:param_name] = 'access_token'
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('action/oauth2/user').parsed
      end

      def email
        raw_info['email']
      end

      def email_access_allowed?
        options['scope'] =~ /user/
      end

    end
  end
end

OmniAuth.config.add_camelization 'oschina', 'Oschina'
