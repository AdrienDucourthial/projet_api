from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

import mysql.connector

# Database configuration
db_config = {
    'host': 'database',
    'user': 'root',
    'passwd': 'azer',
    'db': 'db_players',
}

# Create a connection to the database
conn = mysql.connector.connect(**db_config)

app = FastAPI()

# default test
@app.get("/")
def read_root():
    return {"Hello": "World"}

# Pydantic model to define the schema of the data
class Player(BaseModel):
    player_name: str


# Route to create an item
@app.post("/player", response_model=Player)
def create_item(player: Player):
    cursor = conn.cursor()
    query = "INSERT INTO players (player_name) VALUES (%s)"
    cursor.execute(query, (player.name))
    conn.commit()
    player.id = cursor.lastrowid
    cursor.close()
    return player


# Route to read an item
@app.get("/player/{id_player}", response_model=Player)
def read_item(id_player: int):
    cursor = conn.cursor()
    query = "SELECT id_player, player_name FROM players WHERE id_player=%s"
    cursor.execute(query, (id_player,))
    player = cursor.fetchone()
    cursor.close()
    if player is None:
        raise HTTPException(status_code=404, detail="Player not found")
    return {"id_player": player[0], "player_name": player[1]}

# # Route to update an item
@app.put("/items/{item_id}", response_model=Item)
def update_item(item_id: int, item: Item):
    cursor = conn.cursor()
    query = "UPDATE items SET name=%s, description=%s WHERE id=%s"
    cursor.execute(query, (item.name, item.description, item_id))
    conn.commit()
    cursor.close()
    item.id = item_id
    return item

# # Route to delete an item
@app.delete("/items/{item_id}", response_model=Item)
def delete_item(item_id: int):
    cursor = conn.cursor()
    query = "DELETE FROM items WHERE id=%s"
    cursor.execute(query, (item_id,))
    conn.commit()
    cursor.close()
    return {"id": item_id}

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="localhost", port=8000)


