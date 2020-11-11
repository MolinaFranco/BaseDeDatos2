db.films.find({}, {})
db.films.find({Rating:'PG-13'}, {Title:1, 'Special Features':1})
db.films.distinct('Length')
db.films.find({'Replacement Cost':{$gte:'20.00',$lte:'24.00'}}, {Title:1, 'Rental Duration':1, 'Remplacement Cost':1})
db.films.find({'Special Features':'Behind the Scenes'}, {Title:1, 'Category':1, 'Rating':1, 'Special Features':1})
db.films.find({'Title':'ZOOLANDER FICTION'},{"Actors.First name":1, "Actors.Last name":1})
db.stores.find({_id:1},{'Address':1,'City':1, 'Country':1})

var by_rating = {}
db.films.find({},{}).forEach((film)=> { 
    if (by_rating[film.Rating]==undefined){by_rating[film.Rating] = []}
    by_rating[film.Rating].push({'Title':film.Title,'Rating':film.Rating})
});
printjson(by_rating);


var pares = {}
db.films.find({},{}).forEach((film)=> { 
    db.films.find({'Rating':film.Rating, 'Titulo':{$ne:film.Title}},{}).forEach((par)=>{
        pares.push({'Titulo1':film.Titulo, 'Titulo2':par.Titulo})
})
})
printjson(pares);

var staff_store2_names = {}
var films_available = []
db.stores.find({_id:2}, {}).forEach(staff=>{
    var fn = staff.Staff[0]['First Name']
    var ln = staff.Staff[0]['Last Name']
    var id =staff.Staff[0].staffId.value
    staff_store2_names[id] = {'First Name':fn,'Last Name':ln}
})
printjson(staff_store2_names);
