class EnvController < ApplicationController
  def show
    headers = request.headers.inject({}) do |hash, (key, value)|
      hash[key] = value # if key ~= /HTTP_/
      hash.merge!(key => value)
    end
    render json: JSON.pretty_generate(headers)
  end
end
