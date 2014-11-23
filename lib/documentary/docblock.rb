module Documentary
  class Docblock < OpenStruct
    def initialize(hsh)
      super(hsh)
      self.type = self.type.to_sym
    end
  end
end
