
class Instrumento {
    var property revisiones = []
    method registrarRevision(fecha,tecnico) {
        const nuevaRevision = new Revision(fechaRevision = fecha, tecnico = tecnico)
        revisiones.add(nuevaRevision)
    }

    method afinacion()//10 corresponde a un instrumento afinado y 0 a uno desafinado
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

    override method afinacion()= 10
    
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
    var sordina
    override method afinacion(){
      if (temperatura.between(20,25)){
        return 10
      } else if (temperatura<20) {
        self.calentarMetal()
        return 0
      } else {
        return 0
      }
    }
    method calentarMetal() = temperatura + 1
    
    override method costo(){
        var costo = 30
        if (sordina) {
            costo += 5
        }
        return costo
    }
    override method esValioso() = false
    override method familia()="vientos"
}

class Bechstein inherits Instrumento{
    var anchoSalon 
    var largoSalon
    method revisionDeFabrica(){
        self.registrarRevision(new Date(), "Fabrica")
    }
    
    override method afinacion (){
        var superficieSalon = anchoSalon * largoSalon
          if (superficieSalon > 20 ){
            return 10
        } else{return 0}
    }
    override method costo()= 2*anchoSalon
    override method esValioso() = self.afinacion() == 10
    override method familia()="cuerdas"

}

class Stagg inherits Instrumento{
  var tremolos = 0
  const property pintura  
    override method afinacion ()=10
    method hacerTremolo(){
        tremolos =tremolos + 1
    } 

    override method costo()=(20-tremolos).max(15)

    override method esValioso ()= pintura == "laca acrilica"
    override method familia()= "cuerdas"

}
