import redis

REDIS_PORT = 6379
REDIS_HOST = 'localhost'

r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=0)

a = True
while a:

    print ('que quiere hacer? add/show/exit')
    res1 = input()

    if res1 == 'add':
        print("Ingrese su nombre:")
        nombre = input()
        print("Ingrese el rubro en el que trabajo")
        rubro = input()
        print("Ingrese la cantidad de horas trabajadas:")
        horas = input()
        r.set(nombre, rubro, horas)
    elif res1== 'show':
        print("Todas las horas tageadas")
        print(r.keys())
    elif res1== 'exit':
        a = False
    else:
        print('Ingrese opcion valida')


