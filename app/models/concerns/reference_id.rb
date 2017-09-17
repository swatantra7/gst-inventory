require 'active_support/concern'

module ReferenceId
  extend ActiveSupport::Concern

  included do

    def self.referenced_with(options={})
      length = options[:length] || 6
      prefix = options[:prefix]
      prefix_length = prefix.length
      length_of_reference_id = length - prefix_length

      define_method(:reference_id) do
        "#{prefix}%0#{length_of_reference_id}d" % "#{id}"
      end
    end

  end

end