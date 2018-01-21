module Web
  class Router < Routes::Base
    route do |r|
      r.on 'api/v1' do
        r.on 'transactions' do
          r.run Routes::Transactions
        end
      end
    end
  end
end
