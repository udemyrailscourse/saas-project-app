json.array!(@artifacts) do |artifact|
  json.extract! artifact, :id, :name, :key, :project_id
  json.url artifact_url(artifact, format: :json)
end
