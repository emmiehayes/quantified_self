# Quantified Self

### System Dependencies:
- Ruby version 2.4.1
- Rails version 5.1.6

### Deployed with Heroku:

https://calorie-me.herokuapp.com/

### To run locally:

`git clone repo`

`cd quantified_self`

`bundle update`

`rails db:{create,migrate,seed}`

`rails s`

`http://localhost:3000`

### To run test suite: 

`rspec`



# DOCUMENTATION

## Food Endpoints:

#### GET /api/v1/foods
- Retrieve all foods currently in the database
- If successful, this request will return a response in the following format:
  
```
[{
    "id": 1,
    "name": "Strawberries",
    "calories": 10
 },
 {
    "id": 2,
    "name": "Blueberries",
    "calories": 15
 },
 {
    "id": 3,
    "name": "Pineapple",
    "calories": 20
 },
 {
    "id": 4,
    "name": "Banana",
    "calories": 150
  }]
```

#### GET /api/v1/foods/:id
- Retrieve a single food based on the :id
- If the food is not found, a 404 will be returned.
- If successful, this request will return a response in the following format:
  
```
{
    "id": 2,
    "name": "Cookie",
    "calories": 88
}
```

#### POST /api/v1/foods
- Create a single food 
- ***Both name and calories are required parameters.*** 
- If the food is not successfully created, a 400 status code will be returned. 
- If successful, this request will return a response in the following format:
  
```
{
    "id": 3,
    "name": "Waffle",
    "calories": 67
}
```

#### PATCH /api/v1/foods/:id  
- Update an existing food 
- ***Only field(s) updated are required parameters.*** 
- If the food is not successfully updated, a 400 status code will be returned.
- If successful, this request will return a response in the following format:
  
```
{
    "id": 4,
    "name": "Banana",
    "calories": 140
}
```

#### DELETE /api/v1/foods/:id
- Delete and exisiting food 
- If the food can’t be found, a 404 will be returned.
- If successful, the request will return a 204 status code.


## Meal Endpoints:

#### GET /api/v1/meals

- Retrieve all the meals along with their associated foods
- If successful, this request will return a response in the following format:

```
[
    {
        "id": 1,
        "name": "Breakfast",
        "foods": [
            {
                "id": 4,
                "name": "Banana",
                "calories": 140
            },
            {
                "id": 3,
                "name": "Waffle",
                "calories": 67
            },
            {
                "id": 12,
                "name": "Honey",
                "calories": 60
            }
        ]
    },
    {
        "id": 2,
        "name": "Lunch",
        "foods": [
            {
                "id": 3,
                "name": "Avocado",
                "calories": 67
            },
            {
                "id": 4,
                "name": "Toast",
                "calories": 15
            },
        ]
    }
]
```

#### GET /api/v1/meals/:meal_id/foods

- Retrieve all foods associated with a single meal 
- If the meal is not found, a 404 will be returned.
- If successful, this request will return a response in the following format:

```
{
    "id": 1,
    "name": "Breakfast",
    "foods": [
        {
            "id": 1,
            "name": "Banana",
            "calories": 140
        },
        {
            "id": 6,
            "name": "Waffle",
            "calories": 67
        },
        {
            "id": 12,
            "name": "Honey",
            "calories": 60
        }
    ]
}
```

#### POST /api/v1/meals/:meal_id/foods/:id

- Add a single food to a meal 
- If the food is not successfully added to the meal, a 400 status code will be returned. 
- If successful, this request will return a response in the following format:

```
{
    "message": "Successfully added Honey to Breakfast"
}
```


#### DELETE /api/v1/meals/:meal_id/foods/:id

- Delete a single food from a meal
- If the food is not listed for the meal, a 404 will be returned.
- If successful, this request will return a response in the following format:

```
{
    "message": "Successfully removed Banana from Breakfast"
}
```

## Favorites Endpoints:

#### GET /api/v1/favorite_foods

- Retrieve a list of foods (based on consumption), organized by `timesEaten` in descending order (up to three)
- Only foods consumed more than once will be considered
- If successful, this request will return a response in the following format:

```
[
    {
        "timesEaten": 3,
        "foods": [
            {
                "id": 3,
                "name": "Honey",
                "calories": 10,
                "mealsWhenEaten": [
                    "Breakfast",
                    "Snack"
                ]
            },
            {
                "id": 2,
                "name": "Waffle",
                "calories": 10,
                "mealsWhenEaten": [
                    "Breakfast",
                    "Lunch"
                ]
            }
        ]
    },
    {
        "timesEaten": 2,
        "foods": [
            {
                "id": 1,
                "name": "Banana",
                "calories": 10,
                "mealsWhenEaten": [
                    "Breakfast",
                    "Lunch"
                ]
            },
        ]
    }
]
```
