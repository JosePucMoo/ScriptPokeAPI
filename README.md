# Pokemon Info Script

Este script en Bash permite obtener información de un Pokémon específico desde la [PokeAPI](https://pokeapi.co/) y guardar los datos en un archivo CSV para referencia futura.

## Requisitos Previos

Antes de ejecutar el script, asegúrate de tener instalados los siguientes programas:

- `curl`: Para realizar solicitudes HTTP a la API.
- `jq`: Para procesar los datos JSON obtenidos de la API.

Puedes instalarlos con los siguientes comandos:

```bash
sudo apt install curl jq      # En distribuciones basadas en Debian (Ubuntu, etc.)
sudo dnf install curl jq      # En Fedora
brew install curl jq          # En macOS (usando Homebrew)
```

## Uso

Para ejecutar el script, usa el siguiente comando:

```bash
bash pokescript.sh <nombre_pokemon>
```

Por ejemplo:

```bash
bash pokescript.sh ditto
```

### **Salida esperada**

Si el Pokémon existe, se imprimirá información como la siguiente:

```
Ditto (No. 132)
Id = 132
Weight = 40
Height = 4
```

Además, se guardará en el archivo `pokemon_data.csv` en formato:

```
id,name,weight,height,order
132,ditto,40,4,214
```

### **Validaciones del script**

El script realiza varias validaciones antes de ejecutar la consulta:

1. **Verifica si se proporcionó un nombre de Pokémon.**
2. **Valida que el nombre solo contenga caracteres alfanuméricos y guiones.**
3. **Confirma que la API devuelve datos válidos.**
4. **Evita repetir el encabezado del archivo CSV.**
5. **Verifica que los datos no estén vacíos antes de guardarlos.**

### **Notas adicionales**

- Si el Pokémon no existe o la API no responde correctamente, el script mostrará un mensaje de error.
- El archivo `pokemon_data.csv` mantiene un historial de los Pokémon consultados.

---
