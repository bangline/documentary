module Documentary
  class Docblock < OpenStruct
    def initialize(hsh)
      super(hsh)
      self.type = self.type.to_sym
      self.order = self.order || 9999
    end
  end
end
