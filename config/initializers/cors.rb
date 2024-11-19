Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"  # Allow the React frontend (if running on port 3001)
    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
      expose: [ "Access-Control-Allow-Origin" ]
  end
end
