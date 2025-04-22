from openai import OpenAI

client = OpenAI(
  api_key="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"
)

completion = client.chat.completions.create(
  model="gpt-4o-mini",
  store=True,
  messages=[
    {"role": "user", "content": "describeme el producto cargado, su uso y dime donde lo puedo conseguir junto con su precio"},
  ]
)

print(completion['choices'][0]['message']['content']);