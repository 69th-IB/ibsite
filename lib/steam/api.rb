module Steam
  module API
    BASE_URL = "https://api.steampowered.com/".freeze

    def self.request(path, params = {})
      params[:key] = Rails.application.credentials.steam.api_key

      response = HTTParty.get(BASE_URL + path, query: params)

      if response.code == 200
        return response.parsed_response
      else
        raise "Steam API request failed: #{response.code} #{response.body}"
      end
    end

    module PublishedFileService
      def self.get_details(published_file_id, **options)
        Steam::API::request("IPublishedFileService/GetDetails/v1/", {
          "publishedfileids[0]" => published_file_id,
          short_description: true,
          strip_description_bbcode: true,
          **options
        }).dig("response", "publishedfiledetails")&.first
      end

      def self.query_files(query, **options)
        Steam::API::request "IPublishedFileService/QueryFiles/v1/", {
          search_text: query,
          appid: 107410,
          numperpage: 10,
          return_short_description: true,
          strip_description_bbcode: true,
          **options
        }
      end
    end
  end
end
