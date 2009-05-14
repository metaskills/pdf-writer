
unless RUBY_VERSION < '1.9'
  class ::Mutex
    def marshal_dump
    end unless method_defined?(:marshal_dump)
    def marshal_load(data)
    end unless method_defined?(:marshal_load)
  end
end


