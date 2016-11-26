RSpec::Matchers.define :match_json_schema do |schema|
  match do |response|
    begin
      # TODO: Manually go through EACH schema file and the Twitter API docs to get a proper
      #       assessment of which fields are required and what types are permissible. Note that the
      #       Twitter API gem we're using also slightly changes the format of the returned data
      #       which makes the checking even more hellish.
      JSON::Validator.validate!(
        "#{Dir.pwd}/spec/support/json_schemas/#{schema}.json",
        response.body
      )
    end
  end
end