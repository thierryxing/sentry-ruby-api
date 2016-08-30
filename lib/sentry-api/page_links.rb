module SentryApi
  # Parses link header.
  #
  # @private
  class PageLinks
    HEADER_LINK = 'Link'.freeze
    DELIM_LINKS = ','.freeze
    LINK_REGEX = /<([^>]+)>; rel=\"([^\"]+)\"; results=\"([^\"]+)\"/
    METAS = %w(previous next)

    attr_accessor(*METAS)

    def initialize(headers)
      link_header = headers[HEADER_LINK]

      if link_header && link_header =~ /(previous|next)/
        extract_links(link_header)
      end
    end

    private

    def extract_links(header)
      header.split(DELIM_LINKS).each do |link|
        LINK_REGEX.match(link.strip) do |match|
          url, meta, results = match[1], match[2], match[3]
          next if !url or !meta or !(results == "true") or METAS.index(meta).nil?
          self.send("#{meta}=", url)
        end
      end
    end
  end
end
