import requests

response = requests.post(
    "https://api.deepai.org/api/text-generator",
    data={'text': 'Escribe un poema sobre la tecnología.'},
    headers={'api-key': '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'}
)

print(response.json()['output'])
