class EnvController < ApplicationController
  def show
    headers_hash = request.headers.inject({}) do |hash, (key, value)|
      hash[key] = value if key ~= /^HTTP_/
      hash.merge!(key => value)
    end
    render json: JSON.pretty_generate(headers_hash)
  end
end
