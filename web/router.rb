module Web
  class Router < Routes::Base
    route do |r|
      r.on 'api/v1' do
        r.on 'hello' do
          r.run Routes::Hello
        end
      end
    end
  end
end
