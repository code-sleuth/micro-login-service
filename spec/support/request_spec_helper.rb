module RequestSpecHelper
    def json
        json.parse(response.body)
    end
end