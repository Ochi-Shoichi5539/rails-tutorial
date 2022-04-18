class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world! hola, mundo!"
  end
end
