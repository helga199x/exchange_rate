require "exchange_rate/version"
require 'net/http'
require 'json'
require 'logger'

module ExchangeRate
  class Converter

    ALLOWED_CURRENCY = %w[ EUR USD ].freeze
    RESULT_FIELDS = %w[result success info].freeze

    def initialize(from_currency, to_currency, amount)
      @from_currency = from_currency
      @to_currency = to_currency
      @amount = amount
    end

    def call
      begin
        raise ValidationError.new unless validate_params
        response = Net::HTTP.get(uri_builder)
        response_obj = JSON.parse(response)

        result = RESULT_FIELDS.each_with_object({}) do |field, result|
          result[field] = response_obj.dig(field)
        end

        return result
      rescue => e
        Logger.new(STDOUT).error e

        return { 'success' => false, 'msg' => e.message }
      end
    end

    private

    def validate_params
      [ALLOWED_CURRENCY.include?(@from_currency),
       ALLOWED_CURRENCY.include?(@to_currency),
       @amount > 0].all?
    end

    def uri_builder
      url = "https://api.exchangerate.host/convert?from=#{@from_currency}&to=#{@to_currency}&amount=#{@amount}"
      URI(url)
    end
  end

  class ValidationError < StandardError;
    def initialize
      super
    end

    def message
      'Params are invalid'
    end
  end
end
