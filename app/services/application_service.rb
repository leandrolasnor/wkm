# frozen_string_literal: true

class ApplicationService
  extend Dry::Initializer

  def self.call(args)
    validator = self::Schema.call(args.to_h)
    if validator.success?
      content, status, serializer = new(args).call
      return { content: content, status: status, serializer: serializer }
    end

    { content: validator.errors.to_h, status: :unprocessable_entity }
  end
end
