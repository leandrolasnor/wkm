# frozen_string_literal: true

class ApplicationService
  extend Dry::Initializer

  def self.call(args)
    contract = self::Contract.call(args.to_h)
    if contract.success?
      content, status, serializer = new(args).call
      return { content: content, status: status, serializer: serializer }
    end

    { content: contract.errors.to_h, status: :unprocessable_entity }
  end
end
