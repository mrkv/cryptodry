Container.boot(:web_application) do
  use :router

  start do
    app = Rack::Builder.new do
      run Container.resolve(:router)
    end.freeze

    register(:web_application, app)
  end
end
