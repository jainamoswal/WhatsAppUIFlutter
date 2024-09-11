import json 

with open('raw.json') as f:
    users_data = json.load(f)

new_user_data = []

for user in users_data.get('results'):
    new_user_data.append(
        {
            'first': user['name']['first'],
            'last': user['name']['last'],
            'photo': user['picture']['large'],
        }
    )

with open('users.json', 'w') as f:
    json.dump(new_user_data, f)