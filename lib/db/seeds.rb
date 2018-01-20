class Seeds
  include Import[:db]

  def run
    # countries = [
    #   { name: 'Russia' }
    # ]

    db.transaction do
      # countries.each do |attributes|
      #   db[:countries].insert(attributes)
      # end
    end
  end
end
