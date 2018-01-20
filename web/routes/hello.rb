module Web
  module Routes
    class Hello < Base
      route do |r|
        r.get 'world' do
          { message: 'hello world' }.to_json
        end
      end
    end
  end
end
