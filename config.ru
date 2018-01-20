require_relative 'system/boot'
Container.finalize!

run Container.resolve(:web_application)
