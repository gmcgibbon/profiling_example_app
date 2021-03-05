run ->(env) do
  sleep(10)
  [
    200,
    {"Content-Type" => "text/plain"},
    [
      <<~BODY
        #{10_000.times.map { "other: ignore" }.join("\n")}
        local: $10.00
      BODY
    ]
  ]
end
