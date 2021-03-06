require 'blockenspiel'
require 'railsyard/backend/dsl/base'
require 'railsyard/backend/config/edit_group'
require 'railsyard/backend/config/edit_field'

module Railsyard
  module Backend
    module Dsl

      class Edit < Base
        def group(name, &block)
          config.add_group Config::EditGroup.new(name, &block)
        end

        def field(name, &block)
          config.add_field_to_default_group Config::EditField.new(name, &block)
        end
      end

    end
  end
end
