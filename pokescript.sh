# Verifica si se proporcionó un argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <nombre_pokemon>"
    exit 1
fi

# Verifica si el nombre del Pokémon es válido (solo letras y números permitidos)
if [[ ! "$1" =~ ^[a-zA-Z0-9-]+$ ]]; then
    echo "Error: El nombre del Pokémon contiene caracteres inválidos."
    exit 1
fi

POKEMON=$1
API_URL="https://pokeapi.co/api/v2/pokemon/$POKEMON"
CSV_FILE="pokemon_data.csv"

# Realiza la solicitud a la API
RESPONSE=$(curl -s "$API_URL")

# Verifica si la respuesta contiene un error
if echo "$RESPONSE" | jq -e . >/dev/null 2>&1; then
    ID=$(echo "$RESPONSE" | jq -r .id)
    NAME=$(echo "$RESPONSE" | jq -r .name)
    WEIGHT=$(echo "$RESPONSE" | jq -r .weight)
    HEIGHT=$(echo "$RESPONSE" | jq -r .height)
    ORDER=$(echo "$RESPONSE" | jq -r .order)
    
    # Verifica que los valores no sean nulos o vacíos
    if [ -z "$ID" ] || [ -z "$NAME" ] || [ -z "$WEIGHT" ] || [ -z "$HEIGHT" ] || [ -z "$ORDER" ]; then
        echo "Error: La respuesta de la API no contiene datos válidos."
        exit 1
    fi
    
    # Imprime los resultados en el formato especificado
    echo "$NAME (No. $ORDER)"
    echo "Id = $ID"
    echo "Weight = $WEIGHT"
    echo "Height = $HEIGHT"
    
    # Asegura que el archivo CSV existe
    touch "$CSV_FILE"
    if [ ! -s "$CSV_FILE" ]; then
        echo "id,name,weight,height,order" > "$CSV_FILE"
    fi
    
    # Agrega los datos al archivo CSV
    echo "$ID,$NAME,$WEIGHT,$HEIGHT,$ORDER" >> "$CSV_FILE"
else
    echo "Error: No se encontró información para el Pokémon '$POKEMON'"
    exit 1
fi
