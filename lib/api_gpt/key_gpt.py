from openai import OpenAI

client = OpenAI(
  api_key="our_secret_key", # TODO Replace with your actual API key
)

completion = client.chat.completions.create(
  model="gpt-4o-mini",
  store=True,
  messages=[
    {"role": "user", "content": "describeme el producto cargado, su uso y dime donde lo puedo conseguir junto con su precio"},
  ]
)

print(completion['choices'][0]['message']['content']);