## Foreword

First of all, thanks for taking the time to take this tech challenge. We really appreciate it. And now, are you ready to rumble? :)

## Robot World

It's the year 2020, the developers are part of the past. You are probably the last dev on the earth and you are pretty busy, so you decide the best is the robots can handle all the work instead of you.

## Robot builder and initial data structure.

This robot will be the one in charge to generate the data that will feed the whole process.

- Model a Car factory and the cars. The factory will have 3 assembly lines: “Basic structure”, “Electronic devices” and “Painting and final details”. When the car passes throughout the 3 lines we can consider it as complete.

- The cars have simple parts: 4 wheels, 1 chassis, 1 laser, 1 computer, 1 engine, price, cost price and 2 seats. We should know the car year and the model name. The car computer should know if the car has any defect and where it is (which part). We should know the car model stock.

- We have a warehouse when the cars are parked after completion. We should know how many cars by the model we have in the warehouse. We call this factory stock.

- The cars should answer if it's a complete car or not and its current assembly stage.

- Create a robot builder, once you create the data structure, you have to create a process (our robot builder) which will generate random cars each minute, it will be the one assigning the model names, the year, the parts, the assembly stage, the defects.
  Each minute 10 new cars are created, every day the robot builder process start over from scratch wiping all the cars at the end of the day. Even though the generated cars are randomly generated, we have only 10 different car models.

## Guard robot

- This robot will be looking for any kind of defect, it will send an alert when the defect is detected and it will inform the details using slack.
  Here you go, a curl example (of course you’ll do this using Ruby rather than CURL)

curl -X POST -H 'Content-type: application/json' --data '{"text":"Hello, World!"}' https://hooks.slack.com/services/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

You can check the details here:
https://api.slack.com/docs/messages
Note: The URL => https://hooks.slack.com/services/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 is a real URL, it will post the message you will format to the person who is reviewing the challenge.

## About the stock

The factory stock is different from the store stock. Every 30 minutes the guard robot beside of watching our defects will transfer the stock from factory stock to store stock in order to be sold (it will transfer only the non-defective cars stock).

## Robot buyer, order model and store stock

Once the cars are ready to be sold, the cars are taken to another place, far from the factory and the factory warehouse. Here is where the Robot buyer comes on the scene, this process will buy a random number of cars always < 10 units each X amount of time (it can buy 10 cars/min top). When the robot buyer purchases a car an order will be placed. The robot only can buy 1 car at a time, so each order will have only 1 item. The stock will be decreased when the order is placed. Well, there’s a detail here, the stock we decreased is the store stock. If when the robot buyer wants to purchase a car model and there’s no stock, it won’t be able to buy it and that event will have to be logged.

## The problem.

You know the robot buyer knows the car models he is able to buy, we want to optimize the sales, as we have lag between the factory stock and the store stock, it may happen that we don’t have stock at the store stock but we actually have brand new cars ready to be sold in the factory stock. How can we optimize the stock management? (sadly we can’t centralize the stock)

## The other problem.

After you finish to code this challenge, imagine you'll receive a text message from the robot buyer, it says that several orders need to be changed because they want to change the cars models.
First, you receive an order_id and the car model, but an hour later you'll start to receive several changes of this kind request per hour.
What is your proposal to solve this need? Also please implement the solution.

## A plus.

Making the robot execs happy would be a good idea, it would be great to pull the daily revenue, how many cars we sell, average order value on a daily basis.

## Notes and considerations

- This is a pretty open challenge, there are several ways to solve it, the idea behind this you show us how you think, how you solve the problems. So express yourself, apply the good practices and techniques you learned but always with the right balance, keep it simple.
- Tests are important, we use Rspec, but mini test or another framework will do the job.
- Don't hesitate to ask, we are here to help.
- We use Rails and Postgres. The Postgres DB is mandatory for this challenge, but as this challenge doesn't have front-end, if you feel comfortable using plain ruby it's fine (if you decide to use a framework the only allowed is Rails).

## RESOLUTION

Primero que nada, gracias por darme la oportunidad de hacer este challenge. Fué muy divertido y aprendí un monton.
Quería comentarles algunas consideraciones que tome para que se entienda mejor la resolución.

Usuario de DB: robot-world
Password: password

- Los modelos de los autos (Renault, Peugeot, etc) y los tipos de partes (Rueda1, Motor, asiento1, etc) estan agregados en seeds.rb para que se carguen automaticamente.

- Generé 3 robot con clases estáticas, que son llamados con 'whenever' según solicita el enunciado.

- El constructor de autos (CarFactory) recibe un auto para inicializar, en caso de no recibir ninguno, crea uno nuevo. EL es el encargado de realizar las 3 lineas de ensamble en ese auto.

- Consideré que en la primer linea de producción (Basic Structure) se agregaban las 4 ruedas, el motor, el chasis y los 2 asientos.

- Consideré que en la segunda linea de produccion (Electronic Devices) se agregan el laser y la computadora.

- Consideré que en la tercer linea de producción se pintaba el auto y se movía automaticamente al 'warehouse'

- Considero distintas las 4 ruedas y los 2 asientos, para poder determinar bien cual es la parte que podría estar defectuosa (W1, W2, W3, W3, Seat1, Seat2)

- Considero a la computadora como diferente al resto de las partes, ya que necesito poder accederla y llamar al metodo "has_defects?". Acá estuve un rato pensando cual era la mejor solución. Primero pense en ponerla como una parte mas, al igual que las ruedas y otros componentes, pero al necesitar tener un metodo para chequear fallas, decidí por separarlo y tratarlo diferente. Creé un modelo "Computer", con referencia al auto, ya que si en un futuro la computadora necesita mas propiedades, pueden agregarse facilmente. Cuando terminé todo pensé que también podría haber utilizado una clase estática "Computer" para poder tener el método de clase "has_defects?" pero para dejar la posibilidad abierta de que la computadora tenga mas propiedades, me decidí por esta forma.

- Las partes del auto se generan aleatoriamente, con un 95% probabilidad que salga NO defectuosa

- El RobotGuard elimina los autos con fallas del 'warehouse' al finalizar el día. No se borran los autos en el store ni los vendidos. Tampoco losautos en warehouse sin fallas.

- Creé métodos de clase en la clase "Car" para control de stock como solicita el enunciado.

  - Car.check_factory_stock
  - Car.check_store_stock

- Creé métodos de instancia en la clase "Car" para saber si el auto esta completo o no (En caso negativo devuelve la linea de producción en la que está)

  - is_complete?

- La computadora del auto puede identificar si alguna de las partes del auto tiene defecto, y en caso de tenerlo devuelve un array de partes con defectos

  - has_defects?

- Creé un modelo Event para almacenar todos los sucesos que ocurran con los autos, en un principio para resolver lo que el enunciado solicitaba de dejar registro de la falta de stock de algún modelo de auto en particular, pero luego me pareció útil dejar registrado cuando un auto pasaba por cada linea de producción, cuando se movía al 'warehouse', cuando se movía a la tienda, cuando se vendía, y cuando solicitaban un cambio de modelo en una orden. La tabla en la base tiene muchos valores null, ya que dependiendo del tipo de evento se refiere a un auto, un modelo de auto o una orden. Esta parte creo que la refactorizaría y colocaría una bitácora para cara modelo por separado(car_events, model_events y order_events).

- En un caso real no pondría los "status" del auto o el nombre de los eventos como tipo string, sino que los pondría aparte en una table "type" correspondiente para cada caso. Por ejemplo tengo el "status" de cada auto de tipo string (Por ejemplo 'complete' o 'sold'). Eso sería mejor llevarlo a un model "car_status", y referenciarlo a cada auto con un identificador. Lo mismo con los tipos de eventos que registro en el modelo "Event"

- Creé una API para consultar los datos de estadísticas pero ademas para hacer consultas sobre los autos, eventos, modelos de autos, etc. Para ello utilicé Active Modal Serializers:

  - localhost:3000/api/v1/cars -> Listado de autos
  - localhost:3000/api/v1/cars/:id -> Info de un auto
  - localhost:3000/api/v1/events/ -> Listado de todos los eventos
  - localhost:3000/api/v1/events/car/:id -> Información de eventos de un auto
  - localhost:3000/api/v1/events/type/:name -> Información de eventos de un tipo en particular - Missing Stock - Moved to Store - Basic Structure Done - Electronic Devices Done - Complete in Warehouse - Sold - Order changed
  - localhost:3000/api/v1/events/model/:model_id -> Información de eventos de un modelo de auto en particular (Útilpara encontrar faltantes de stock)
  - localhost:3000/api/v1/stats/daily -> Estadísticas de ventas del día de hoy

- En cuanto al primer problema que nombra el enunciado, del lag entre el 'warehouse' y la tienda, lo primero a tener en cuenta es que en el challenge, la creación de autos es por modelos aleatorios. Haciendo uso de las estadísticas que podamos obtener de la tabla de eventos, podemos determinar los autos mas solicitados en las tiendas y podríamos anticiparnos a estos eventos de stock faltante y fabricar y enviar a las tiendas mas autos de los modelos requeridos. Lo mismo con los autos que se encuentran listos en el 'warehouse'. Usando las estadísticas podríamos enviar antes de tiempo, modelos que sean muy solicitados y evitar la falta de stock.

- En cuanto al problema número dos, de los cambios de modelo en ordenes ya realizados por el RobotBuyer, implementé la solución con un metodo estático "change_order". El mismo recibe un order_ir y un modelo de auto nuevo. Primero revisa que la orden exista, luego que haya stock en tienda del nuevo modelo que se solicitó. Si no hay, no se realiza ningún cambio (Se agrega una linea en los eventos con stock faltante de ese nuevo modelo). En caso de haber stock del nuevo modelo, se devuelve el auto actual de la orden (metodo "return_car" en la clase "Car"), lo cual modifica la ubicación del auto (pasa de "sold" a "store") y el estado del auto (Pasa de "sold" a "complete"). Luego de devolver el auto, se procede a la compra del auto con modelo nuevo, y se le asigna a la orden correspondiente.

- El Mensaje a Slack se envía 'inline'. Tiene información de la cantidad de autos con defectos y un link para poder ver en mas detalle en formato Json los autos y sus partes defectuosas. Como es una versión de desarrollo corriendo como localhost, el link apunta a http://localhost:3000 por lo que para que funcione debe estar corriendo el servidor rails en la misma PC.

- Al principio puse el envío del mensaje de slack como asincrono en un job (No lo eliminé asique pueden verlo en slack_defective_cars_job.rb). Funcionaba bien ejecutandolo desde la consola, pero desde las tareas en el crontab, la llamada asincrona no se realizaba. Investigué un poco e instalé sidekiq y redis para poder tener los jobs en memoria, pero creo que se iba un poco del objetivo del challenge, asique decidí ponerlo inline y que envié el mensaje de forma sincrona.

- En el archivo constants.rb coloqué la URL de slack.

- Realicé los tests con Rspec. Hice de los modelos y de los requests.

- Traté de generarles un archivo docker-compose.yml para que sea mas facil la prueba de este challenge (Tanto un server rails como uno postgres), pero no llegué con el tiempo (está hasta donde llegué los archivos Dockerfile y docker-compose.yml)
