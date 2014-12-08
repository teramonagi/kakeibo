json.array!(@accountbooks) do |accountbook|
  json.extract! accountbook, :id, :date, :amount, :person, :content
  json.url accountbook_url(accountbook, format: :json)
end
