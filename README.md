This is a Simple Chat API built using Ruby on Rails 7

Step to run and intialize:
1. clone this repository 
2. make sure your PC has installed Ruby on Rails 7 (can search on internet, many guides)
3. in Terminal type "rails s"
4. if localhost:3000 show dashboard with rails logo then it is working
5. install postman (can use other too like insomnia)
5. Create User with http://localhost:3000/api/v1/user (see below)
6. Create some example conversation using http://localhost:3000/api/v1/conversation (see below)

API Specification

1. http://localhost:3000/api/v1/conversation <br />
    Example Body: <br />
    {
        "name": "Maya"
    }
    <br /> Example Result:
    {
        "id": 4,
        "name": "Maya",
        "created_at": "2022-12-16T03:57:33.645Z",
        "updated_at": "2022-12-16T03:57:33.645Z"
    }

2. http://localhost:3000/api/v1/conversation <br />
    Example Body: <br />
    {
        "user_id_from": 3,
        "user_id_to": 1,
        "message": "oi",
        "read_status": false
    }
    <br /> Example Result:
    {
        "id": 22,
        "user_id_from": 3,
        "user_id_to": 1,
        "message": "oi",
        "read_status": false,
        "room_id": 4,
        "created_at": "2022-12-16T03:22:04.238Z",
        "updated_at": "2022-12-16T03:22:04.238Z"
    }
Note: if "message" key is empty , it will not be saved to database and not returning JSON

3. http://localhost:3000/api/v1/currentChat <br />
    Example Body: <br />
    {
        "user_id_from": 3,
        "user_id_to": 1
    }
    <br /> Example Result:
    [
        {
            "id": 15,
            "user_id_from": 1,
            "user_id_to": 3,
            "message": "yawa",
            "read_status": true,
            "room_id": 4,
            "created_at": "2022-12-16T02:59:08.388Z",
            "updated_at": "2022-12-16T02:59:08.388Z"
        },
        {
            "id": 16,
            "user_id_from": 3,
            "user_id_to": 1,
            "message": "wawa",
            "read_status": true,
            "room_id": 4,
            "created_at": "2022-12-16T02:59:21.327Z",
            "updated_at": "2022-12-16T02:59:21.327Z"
        },
        {
            "id": 19,
            "user_id_from": 1,
            "user_id_to": 3,
            "message": "kay",
            "read_status": true,
            "room_id": 4,
            "created_at": "2022-12-16T03:11:12.512Z",
            "updated_at": "2022-12-16T03:11:12.512Z"
        }
    ]

4. http://localhost:3000/api/v1/seeAllChat/1 ("1" is user_id) <br />
    Example Result:
    [
        {
            "user_id_from": 1,
            "user_id_to": 2,
            "name_from": "Kevin",
            "name_to": "Jaka",
            "message": "ok",
            "read_status": true,
            "unread_count": 1,
            "id": 18
        },
        {
            "user_id_from": 3,
            "user_id_to": 1,
            "name_from": "Mira",
            "name_to": "Kevin",
            "message": "oi",
            "read_status": false,
            "unread_count": 3,
            "id": 22
        }
    ]
