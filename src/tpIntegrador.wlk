
class Instrumento {
    var property revisiones = []
    method registrarRevision(fecha,tecnico) {
        const nuevaRevision = new Revision(fechaRevision = fecha, tecnico = tecnico)
        revisiones.add(nuevaRevision)
    }

    method afinacion()//true corresponde a un instrumento afinado y false a uno desafinado
    method costo()
    method esValioso()
    method familia
}

class Revision {
    const property fechaRevision
    const property tecnico
}
class Fender inherits Instrumento {
    const color 

    override method afinacion()= true
    
    override method costo(){
        if(color == "negro"){
            return 15
        } else return 10
    }
    override method esValioso()=true
    override method familia()="cuerdas"
}

class Jupiter inherits Instrumento {
    var temperatura 
    const sordina
    override method afinacion(){
        return temperatura.between(20,25)
    }
    method calentarMetal()  { // en el punto 5??
        temperatura=temperatura + 1}
    
    override method costo(){
        var costo = 30
        if (sordina) {
            costo += 5
        }
        return costo
    }
    override method esValioso() = false
    override method familia()="vientos"
    method temp()=temperatura
}

class Bechstein inherits Instrumento{
    const anchoSalon 
    const largoSalon
    method revisionDeFabrica(){
        self.registrarRevision(new Date(), "Fabrica")
    }
    
    override method afinacion (){
     const superficieSalon = anchoSalon * largoSalon
        return superficieSalon > 20
    }
    override method costo()= 2*anchoSalon
    override method esValioso() = self.afinacion()
    override method familia()="cuerdas"

}

class Stagg inherits Instrumento{
    var tremolos = 0
    const property pintura  
    override method afinacion (){
        return tremolos<10
    }
    
    method hacerTremolo(){
        tremolos =tremolos + 1
    } 

    override method costo()=(20-tremolos).max(15)

    override method esValioso ()= pintura == "laca acrilica"
    override method familia()= "cuerdas"

}
//