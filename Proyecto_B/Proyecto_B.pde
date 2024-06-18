//VARIABLES GLOBALES

//IMPORTACIÓN DE LIBRERIA MINIM:

//Es utilizada para cargar y manipular audio
import ddf.minim.*; //importar libreria minim de otra plataforma para trabajar con tarjeta de audio
Minim minim; //decalarar variable "minim" de la libreria. Permitir que inetractivo se conecte al audio
AudioPlayer music; //nombre de que se le pone (Identificador o variable GLOBAL) al audio para cargarlo y manipularlo


//CREACION DE CAPA:

//Tipo de Clase para crear gráficos fuera de la pantalla.
//Se construye con funciones: createGrpahics (); beginDraw() y endDraw()
//Permite aislar diferentes elementos o efectos;
PGraphics layer1;
//Layer1 es el nombre de la capa, independiente de la principal. GLOBAL

//Otro tipo de clase
//tipo de datos para almacenar imagenes:
//para que se pueda utilizar la imagen, se tiene que cargar con funcion loadImage()
//permite que la imagen se pueda manipular con WIDTH/HEIGHT/PIXELS
PImage m1;
//nombre que se proporciona a la imagen cargada. GLOBAL

//variables que pueden representar coordenadas, dimensiones, valores numericos que contienen puntos decimales
float angle;
//variable global con nombre "angle" para manipular posteriormente los angulos de rotacion
float anganim = 0;
//variable Global con nombre y valor para manipular animacion

//CREACION DE COLECCION (ARRAY)

//estructura de datos que permite almacenar múltiples valores del mismo tipo
//designar que la variable son valores de colores RGB + opacidad
color [] colArray = {
  color (255, 72, 0),
  color (219, 173, 99),
  color (219, 154, 99),
  color (219, 112, 99),
  color (219, 210, 184)
};

//INICIAR COMPOSICION

//VOID Y DRAW no devuelven un valor
//void setup()= funcion que configura condiciones inciales para la composicion
//void draw() =funcion que repetira la parte animada o interactiva de la composicion

void setup () {

  //TAMAÑO:
  size (1080, 800, P2D);
  //tamaño del trabajo medido por pixeles (ancho x altura).
  //P2D: Renderizador GPU. Mejor rendimiento en operaciones graficas en conjuntos de datos grandes o complejos

  //CAPA:
  layer1 = createGraphics(1080, 1080, P2D);
  //referido a la variablle PGrafics. Se especifica el tamaño en pixeles (ancho x alto), usualmente con las mismas dimensiones que el canvas original
  imageMode(CENTER);
  //alinear imagen de capa en el centro para que la esquina de imagen no sea la que inicia en pixel 0.
  m1 = loadImage ("prueba03.png");
  //cargar un archivo de imagen desde el sistema de archivos local.
  //la imagen debe estar en formato JPG/PNG/GIF para que pueda estar lista para usar.

  //MUSICA:
  minim = new Minim (this);
  //Comando para iniciar Minim y poder cargar y usar el audio. Nueva instancia de la clasepara acceder a las funciones y caracteristicas de la biblioteca
  music=minim.loadFile("campanas.mp3", 1024);
  //Cargar el audio MP3 del archivo local con nombre de la variable
  //El numero 1024 se refiere a la cantidad de muestras que estoy tomando. Esto determina la cantidad de datos de audio que se procesan en cada interación, afecta equilibrio entre rendimiento y latencia.
  music.loop ();
  //Variable "music" se repetirá permanentemente
  
}

//FUNCION que se repite automaticamente
void draw () {


  anganim +=0.002;
  //variable global que tiene valor 0, incrementa el valor de la variable en 0.002 en cada interacion de la funcion DRAW ()
  //Mecanismo de animacion, utilizada para cambiar gradualmente el valor de anganim a lo largo del tiempo
  //manipular rotacion

  //INICIAR DIBUJO CAPA:
  layer1.beginDraw();
  //Explicar que se dibujara en capa ya establecida como "layer 1". Preparacion
  //CONDICIONAL que establece el color de fondo y del y del trazo de la CAPA:
  //Dependiente de posicion actual de la Musica
  if ( music.position()>21690) {
    //Si la posicion de musica es mayor que 21690, establece color de fondo y color de trazo específico
    layer1.background (#B74A0B, 20);
    //se se agregó transpariecia al fondo de valor 20 para realizar EFECTO DE BARRIDO/ESTELA
    layer1.stroke (#F9F6E8);
    //Si la posicion de musica es menor que 2160, se establen otros colores de fondo y de trazo
  } else {
    layer1.background(#F9F6E8, 20);
    //Transpariencia se mantiene para mantener el efecto deseado
    layer1.stroke (#B74A0B);
  }
  layer1.translate (width/2, width/2);
  //el Origen del espacio de dibujo de la CAPA ahora es el CENTRO del lienzo.
  //Posteriores operaciones de dibujo se realizaran con origen en el centro
  layer1.strokeWeight (1.85);
  //establece grosor de los trazos en la CAPA (1.85 son valores en pixeles)
  //LOOP controlado para dibujar 80 lineas en la CAPA en un solo comando
  for ( int l=0; l<80; l++) {
    //(incializacion; condicion; iteracion)
    //En la primera, se asigna un valor incial (l=0);
    //en la condicion, el loop sigue hasta llegar a la condicion del valor (l menor a 80);
    //en la última,se ejecuta despues de cada iteracion del ciclo (l++ incrementa l despues de la iteacion)
    float rad = map(l, 0, 80, 0, TWO_PI);
    //variable para mapear interacion actual a un angulo que cubra el circulo completo (0 a TWO_PI).
    //(variable a cambiar (l), rango actual de 0-80 se cambia a rango 0, TWO_PI)
    //resultado es nombrado RAD, valor en radianes que corresponde a la variable "l"
    layer1.push();
    //guardar el estado de trasnformacion actual de la CAPA
    layer1.rotate(rad);
    //rotacion del dibujo en contexto con la variable creada (RAD) para en cada interacion, sea un lugar distinto y crear el circulo completo
    layer1.line(0, 0, 1000, 0);
    //dibuja una linea en CAPA desde el origen (CENTRO)  al punto 1000 en direccion de la rotacion
    // line (x1,y1,x2,y2);
    layer1.pop();
    //restaurar el estado de transformacion a como push() lo ha guardado
  }
  layer1.endDraw();
  //MARCA FIN de la secuencia de dibujo en la CAPA
  //FINALIZA edicion de capa
  //Layer1 puede utilizarse como imagen o textura en lienzo principal

  push();
  //nuevamente se guarda el estado de transformacion actual del lienzo principal
  translate (width/2, height/2);
  //Origen del espacio de dibujo PRINCIPAL se transporta al CENTRO del lienzo
  //debido a que se encuentra dentro de push() y pop() solo sirve para las instrucciones dentro de estas funciones

  rotate(anganim);
  //rotacion del lienzo segun la variable GLOBAL + 0.002 agregados en DRAW (), que funciona como la velocidad de rotacion
  //rotacion se aplica alrededor del centro del lienzo debido al comando anterior
  image( layer1, 0, 0);
  //Coloca la CAPA creada como imagen en el centro del lienzo
  //la imagen tambien rota debido al comando interior con la variable global (anganim)
  pop();
  //restaura el estado de transformacion al ultimo push()
  //permite transformaciones aisladas y posicionamiento de los graficos dibujados

  image( m1, width/2, height/2);
  //se coloca imagen  del mismo color de background encima de la CAPA en el centro del lienzo,
  //Sirve para dar forma y profundidad a la capa



  //LINEAS DINAMICAS

  translate (width/2, height/2);
  //Origen del espacio de dibujo se transporta al CENTRO del lienzo Principal
  //los siguientes dibujos, se realizaran alrededor del centro del lienzo
  rotate (radians(angle/3));
  //rotacion de figuras subsecuentes
  //Angulo de rotacion es determinado por angle/3 que tambien determina la velocidad de rotacion
  //valores convertidos en radianes



  float l =220;
  //VARIABLE LOCAL tamanio lineas
  float d=20;
  //VARIABLE LOCALtamanio bolitas


  for (int a=0; a<360; a+=10) {
    //Incia LOOP de 0 a 360 en espacio de 10 grados.
    stroke (#3F8982);
    //determina color de trazo en valor hexadecimal
    strokeWeight (2);
    //determina el grosor del trazo a dos pixeles

    push();
    //Guarda nuevamente el estado de transformacion actual

    //FIGURA1
    rotate (radians(a));
    //rotacion al lienzo segun la variable "a"
    //permite crear un circulo dinamico en vez de solamente una linea
    line (l*sin(radians(angle)), 290, 370, l-d/2);
    //Dibuja una linea con los parametros establecidos (color y grosor del trazo)
    //line (x1,y1,x2,y2);
    //La coordenada x1 es calculada con funciones trigonometricas para agregar movimiento dinamico
    //la funcion sin () genera valores entre -1 y 1 segun el angulo proporcionado, creando patron ciclico
    //factor de escala que influye en la amplitud o extension de la linea: a medida que cambia el angulo, hay un valor cambiante
    //y1 y x2 son valores fijos que permiten estabilidad del movimiento
    //y2 es valor fijo pero con espacio especifico para agregar una figura circular

    //FIGURA2:
    noStroke ();
    //la siguiente animacion no tiene trazo
    fill (colArray[int(random(5))]);
    //se agrega la variable Global de coleccion de cinco colores para rellenar las siuientes figuras de manera aleatoria
    ellipse (l*sin(radians(angle)), 290, d/2, d/2);
    //ellipse (a,b,c,d)
    //Dibuja circulo con coordenada calculada con funciones trigonometrica para que el movimiento sea el mismo a las lineas dinamicas
    //los otros valores son fijos que determinan un tamaño especifico para la dinamica de la figura (mitad del tamano para que quepan en la siguiente figura);

    //FIGURA3
    stroke (colArray[int(random(5))]);
    //Trazo de color aleatorio dentro de la variable Global que contiene coleccion de cinco colores
    strokeWeight (2);
    //Grosor de trazo a dos pixeles
    noFill();
    //sin color de relleno
    ellipse (290, l, d, d);
    //figura con valores fijos de variables locales anteriores, tamanio del circulo determinado (d)
    //posicion de circulo (290,l) planeado para no solapar las lineas realizadas y CAPA 1
    pop();
    //restaura estado de transformacion al ultimo push ()
  }
  angle++;
  //variable global que controla velocidad de rotacion; es incrementado por 1

  //FIGURA CENTRO

  float dia =map (music.mix.level (), 0, 0.08, 30, 170);
  //variable que utiliza la funcion de MAP para escalar el nivel actual de volumen de la musica desde el rango 0-0.08 a 30-170)
  //el resultado se almacena en la variable DIA que se utilizara para cambiar el tamanio de las siguientes figuras
  float x=240;
  //variable local x se designa valor de 240
  int num= 8;
  //variable local NUM tiene valor de 8

  for (float c=0; c<360; c+=90) {
    //Se inicia LOOP DE 0 a 360 en espacio de 90 grados, en un menor espacio, se solapan los circulos y se pierde la armonia
    rotate (radians(c));
    //rotacion del sistema de acuerdo con el angulo del LOOP, se transforma en radianes

    push ();
    //Guarda estado de trasnformacion actual
    if ( music.position()>21690) {
      //Condicional que considera posicion de musica mayor a 21690
      fill (#FC9E63, 100);
      //si la condicional es verdadero, se rellena la figura con el valor hexadecimal mencionado y 100% de opacidad
    } else {
      //si es falso, cambia el color de relleno a otro matiz, pero conserva la transparencia
      fill (#7CB8C9, 100);
    }
    for (int ce=0; ce<num; ce++) {
      //Se inicia otro LOOP que considera el valor 0 a variable NUM (8)
      scale (0.45);
      //escala el dibujo en factor de 0.45 pára observar diferentes tamanios de circulos de mayor a menor hacia el centro
      rotate (radians(angle));
      //rotacion de dibujo basado en la variable angle, transformado en radianes
      noStroke();
      //sin trazo
      ellipse (0, x, dia, dia);
      //creacion de circulo con cordenadas especificas
      //inicia con coordenada x y y fijas
      //valores de tamanio estan sujetos al cambio de acuerdo con los niveles de la musica (valores de 30-170). Variable DIA
    }
    pop();
    //Restauracion del estado de transformacion antes de push()

    //MISMO CODIGO CON DIFERENTE DIRECCION
    
    push();
    //Guarda estado de trasnformacion actual
    if ( music.position()>21690) {
      //Condicional que considera posicion de musica mayor a 21690
      fill (#A72A9B, 100);
      //si la condicional es verdadero, se rellena la figura con el valor hexadecimal mencionado y 100% de opacidad
    } else {

      fill (#AFC67C, 100);
      //si es falso, cambia el color de relleno a otro matiz, pero conserva la transparencia
    }
    for (int ce=0; ce<num; ce++) {
      //Se inicia otro LOOP que considera el valor 0 a variable NUM (8)
      scale (0.45);
      //escala el dibujo en factor de 0.45 pára observar diferentes tamanios de circulos de mayor a menor hacia el centro
      rotate (-radians(angle));
      //Rotacion negativa de la variable ANGLE para que la direccion sea la contraria a la figura anterior y no se encimen
      noStroke();
      //sin trazo
      ellipse (x, 0, dia, dia);
      //inicia con coordenada x y y fijas
      //valores de tamanio estan sujetos al cambio de acuerdo con los niveles de la musica (valores de 30-170). Variable DIA
    }
    pop();
    //Restauracion del estado de Transformacion antes de push()
  }
}
