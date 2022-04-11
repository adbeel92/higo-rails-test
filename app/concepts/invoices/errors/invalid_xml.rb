module Invoices
  module Errors
    class InvalidXml < StandardError
      def initialize(msg='XML es inválido')
        super
      end
    end
  end
end
