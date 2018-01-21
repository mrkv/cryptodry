# Class for fake http communication with third party service
# TODO: Randomly generate error to sumulate service unavailability
module Services
  class ThirdPartyService
    def call(card_id)
      # Suppose it does some network communication and returns transactions for card in JSON format
      @transactions = []

      id = rand(100)

      rand(10).times do |i|
        currency = ['USD', 'EUR', 'GBP'].sample
        amount = rand(10000)
        description = "description #{rand(100000)}"
        comment = "comment #{rand(100000)}"

        @transactions << {
          transactionId: id,
          transactionCurrency: currency,
          transactionAmount: amount,
          description: description,
          comment: comment
        }
      end

      JSON.generate(transactionDetails: @transactions)
    end
  end
end
