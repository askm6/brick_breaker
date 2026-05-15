# Análisis de estructura del proyecto Flame

## Objetivo

Analizar la estructura actual del proyecto Brick Breaker para decidir qué partes se reutilizarán, modificarán o eliminarán al convertirlo en un juego Pong de dos jugadores.

## Estructura actual de `lib`

```txt
lib/
 ├─ main.dart
 └─ src/
    ├─ brick_breaker.dart
    ├─ config.dart
    ├─ components/
    │  ├─ ball.dart
    │  ├─ bat.dart
    │  ├─ brick.dart
    │  ├─ components.dart
    │  └─ play_area.dart
    └─ widgets/
       ├─ game_app.dart
       ├─ overlay_screen.dart
       └─ score_card.dart
```

## Análisis de archivos

### `main.dart`

Es el punto de entrada de la aplicación Flutter. Su función principal es lanzar el widget principal del juego.

### `src/widgets/game_app.dart`

Contiene la estructura principal de la app Flutter y conecta el juego de Flame con Flutter mediante `GameWidget`.

Este archivo se mantendrá, pero se modificará para que use el juego Pong en lugar de Brick Breaker.

### `src/brick_breaker.dart`

Es la clase principal del juego. Controla la lógica general, el estado de la partida, los componentes y las interacciones.

Actualmente está pensada para Brick Breaker, pero se reutilizará como base para crear la clase principal del Pong.

### `src/config.dart`

Contiene constantes de configuración como tamaños, colores, velocidad y valores generales del juego.

Este archivo se modificará para que las medidas sean proporcionales al tamaño de pantalla y el juego sea responsive.

### `src/components/ball.dart`

Representa la pelota del juego.

Se reutilizará para Pong, pero habrá que modificar su comportamiento para que rebote entre dos palas y pueda marcar puntos al salir por los lados.

### `src/components/bat.dart`

Representa la pala del jugador en Brick Breaker.

Se reutilizará como base para las dos palas del Pong, pero cambiará su orientación y movimiento. En vez de moverse horizontalmente, las palas se moverán verticalmente.

### `src/components/brick.dart`

Representa los ladrillos del Brick Breaker.

Este componente no será necesario en Pong, por lo que se eliminará o dejará de usarse.

### `src/components/play_area.dart`

Representa el área de juego y sus límites.

Se reutilizará para definir el campo del Pong y controlar los límites superior e inferior.

### `src/components/components.dart`

Archivo que exporta los componentes del juego.

Se modificará cuando eliminemos componentes que ya no se usen, como `brick.dart`.

### `src/widgets/score_card.dart`

Muestra el marcador actual.

Se modificará para mostrar dos puntuaciones: jugador izquierdo y jugador derecho.

### `src/widgets/overlay_screen.dart`

Muestra pantallas superpuestas como inicio, pausa, game over o victoria.

Se reutilizará para mostrar pantalla de inicio, instrucciones y ganador de la partida.

## Decisiones para convertir Brick Breaker en Pong

| Archivo | Acción | Motivo |
|---|---|---|
| `main.dart` | Mantener | Es el punto de entrada de Flutter |
| `game_app.dart` | Modificar | Debe cargar el juego Pong y adaptar textos |
| `brick_breaker.dart` | Modificar o renombrar | Será la clase principal del Pong |
| `config.dart` | Modificar | Hay que adaptar tamaños, velocidades y proporciones |
| `ball.dart` | Reutilizar y modificar | La pelota sigue siendo necesaria |
| `bat.dart` | Reutilizar y modificar | Será la base de las dos palas |
| `brick.dart` | Eliminar o dejar de usar | Pong no utiliza ladrillos |
| `play_area.dart` | Reutilizar y modificar | Servirá como campo de juego |
| `components.dart` | Modificar | Hay que actualizar los exports |
| `score_card.dart` | Modificar | Debe mostrar marcador de dos jugadores |
| `overlay_screen.dart` | Reutilizar y modificar | Servirá para inicio y pantalla de victoria |

## Conclusión

El proyecto Brick Breaker tiene una estructura adecuada para convertirlo en Pong porque ya incluye varios elementos reutilizables: una clase principal de juego, una pelota, una pala, un área de juego, un marcador y pantallas superpuestas.

La conversión a Pong consistirá en eliminar la lógica de ladrillos, añadir una segunda pala, modificar los controles, adaptar el marcador para dos jugadores y hacer que las medidas del juego dependan del tamaño de pantalla para conseguir un diseño responsive.