json.array!(@remote_projects) do |remote_project|
  json.extract! remote_project, :id
  json.url remote_project_url(remote_project, format: :json)
end
