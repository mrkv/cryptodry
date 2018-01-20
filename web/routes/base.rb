module Web
  module Routes
    class Base < Roda
      include IMPORT[:logger]

      DEFAULT_HEADERS = {
        'Content-Type' => 'application/json;charset=UTF-8',
        'Cache-Control' => 'no-store',
        'Pragma' => 'no-cache'
      }.freeze

      plugin :error_handler
      plugin :symbol_status
      plugin :json_parser
      plugin :all_verbs
      plugin :request_headers
      plugin :default_headers, DEFAULT_HEADERS

      error do |e|
        status = nil
        error = nil
        case e.class.name
        when 'Errors::OAuth2InvalidToken', 'Errors::InvalidClient', 'Errors::OAuth2AuthenticationFailed'
          status = 401
        when 'Errors::InvalidRequest'
          status = 400
        when 'Errors::AccessDenied'
          status = 403
        when Errors::Forwarded.name
          status = e.code
          error = e.name
        when 'Errors::Base'
          status = 500
          error = 'InternalServerError'
        else
          status = 500
          error = 'InternalServerError'
          logger.error("#{e.class}: #{e.message}; backtrace: #{e.backtrace}")
        end

        response.status = status
        attributes = {
          code: status,
          error: error || e.class.name.demodulize,
          error_description: e.message
        }
        JSON.generate(attributes)
      end
    end
  end
end
