module Web
  module Routes
    class Transactions < Base
      route do |r|
        r.post do
          transactions_count = Controllers::Transactions::Create.new.call(r.params)
          JSON.generate(result: "Successfully synced #{transactions_count} transactions")
        end
      end
    end
  end
end
