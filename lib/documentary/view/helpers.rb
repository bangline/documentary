module Documentary
  module View
    require 'stringio'

    def toc
      io = StringIO.new
      io.puts "### [Resources](#resources)"
      io.puts new_line
      docblocks.resources.each do |resource|
        io.puts "* #{link_to(resource.title)}"
      end
      io.puts new_line
      io.puts "### [Endpoints](#endpoints)"
      docblocks.endpoints.each do |endpoint|
        io.puts "* #{link_to(endpoint.title)}"
      end
      io.string
    end

    def title_blocks
      io = StringIO.new
      docblocks.title_blocks.each do |title_block|
        io.puts "## #{title_block.title}"
        io.puts new_line
        io.puts title_block.content
        io.puts new_line
      end
      io.string
    end

    def resource_blocks
      io = StringIO.new
      io.puts "## #{link_to('Resources')}"
      io.puts new_line
      docblocks.resources.each do |resource|
        io.puts "### #{link_to(resource.title)}"
        io.puts new_line
        io.puts resource.description
        io.puts new_line
        resource_attributes(resource, io)
      end
      io.puts new_line
      io.string
    end

    def endpoint_blocks
      io = StringIO.new
      io.puts "## #{link_to('Endpoints')}"
      io.puts new_line
      docblocks.endpoints.each do |endpoint|
        io.puts "### #{link_to(endpoint.title)}"
        io.puts new_line
        io.puts endpoint.notes if endpoint.notes
        io.puts new_line
        io.puts '#### Enpoint URL'
        io.puts new_line
        io.puts start_code_block
        io.puts "#{endpoint.verb} #{endpoint.endpoint}"
        io.puts end_code_block
        if endpoint.information
          io.puts '#### Endpoint Information'
          io.puts new_line
          endpoint.information.each do |key, value|
            io.puts "* **#{key.titleize}**: #{value}"
          end
        end
        if endpoint.params
          io.puts new_line
          io.puts '#### Parameters'
          io.puts new_line
          io.puts 'Name     | Required | Description'
          io.puts '-------- | -------- | -----------'
          endpoint.params.each do |param|
            io.puts "#{param.keys.first} | #{param['required']} | #{param['notes'].strip}"
          end
        end
        if endpoint.example_request
          io.puts new_line
          io.puts '#### Example Request'
          io.puts new_line
          example_request = YAML.load(endpoint.example_request)
          if example_request['query']
            io.puts start_code_block
            io.puts "#{endpoint.verb} #{endpoint.endpoint}" << '?' << query_params(example_request['query'])
            io.puts end_code_block
          end
          if example_request['body']
            io.puts start_code_block
            example_request['body'].each do |b|
              io.puts request_payload(b)
              io.puts new_line
            end
            io.puts start_code_block
          end
        end
        if endpoint.example_response
          io.puts new_line
          io.puts '#### Example Response'
          io.puts new_line
          io.puts start_code_block
          io.puts JSON.pretty_generate(endpoint.example_response)
          io.puts end_code_block
        end
      end
      io.string
    end

    def code_block
      '```'
    end

    private

      def link_to(title)
        "[#{title}](##{title.downcase.gsub(' ', '-')})"
      end

      def query_params(params)
        p = params.map {|p| "#{p.keys.first}=#{p[p.keys.first]}"}.join('&')
        URI.escape(p)
      end

      def request_payload(payload)
        case payload['content_type']
        when 'json'
          JSON.pretty_generate(payload['payload'])
        when 'xml'
          payload['payload'].to_xml
        end
      end

      def resource_attributes(resource, io)
        io.puts '#### Attributes'
        io.puts new_line
        io.puts 'Name          | Type          | Required'
        io.puts '------------- | ------------- | -----------------'
        resource.attributes.each do |attribute|
          io.puts "#{attribute.keys.first} | #{attribute['type'] } | #{attribute['required'] }"
        end
      end

      def new_line
        "\n"
      end

      alias_method :start_code_block, :code_block
      alias_method :end_code_block, :code_block

  end
end
