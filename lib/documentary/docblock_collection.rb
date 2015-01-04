module Documentary
  class DocblockCollection
    extend Forwardable

    def_delegators :@collection, :<<, :concat

    def initialize
      @collection = []
    end

    def title_blocks
      fetch_subset :title_block
    end

    def resources
      fetch_subset :resource
    end

    def endpoints
      fetch_subset :endpoint
    end

    private

      attr_reader :collection

      def fetch_subset(type)
        collection.select { |docblock| docblock.type == type }.sort_by { |block| block.order }
      end

  end
end