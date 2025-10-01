
class Instrumento {
    
    var serviceAfinacion = []

    method afinacion()//10 corresponde a un instrumento afinado y 0 a uno desafinado
    method costo()
    method esValioso()
    method familia
}
class Fender inherits Instrumento {
    const color 

    override method afinacion(){
        return 10
    }
    override method costo(){
        if(color == "negro"){
            return 15
        } else return 10
    }
    override method esValioso(){
        return true
    }   
    override method familia(){
        return "cordofono"
    }
}

class Jupiter inherits Instrumento {
    var temperatura 
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
    method calentarMetal() {
        temperatura = temperatura + 1
    }
    override method esValioso(){
        return false
    }
      
}
