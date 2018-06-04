class EnvController < ApplicationController
  def show
    render json: JSON.pretty_generate(ENV.as_json)
  end
end
