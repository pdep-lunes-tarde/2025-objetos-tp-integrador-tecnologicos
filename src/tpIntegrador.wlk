
class Instrumento {
    var property revisiones = []
    method registrarRevision(fecha,tecnico) {
        const nuevaRevision = new Revision(fechaRevision = fecha, tecnico = tecnico)
        revisiones.add(nuevaRevision)
    }

    method estaAfinado()//true corresponde a un instrumento afinado y false a uno desafinado
    method costo()
    method esValioso()
    method familia()
    method esCopado() = false
    method afinar()
    method revisionMenorADosMeses(){
        const fechaDeHoy = new Date()
        const dosMesesAtras = fechaDeHoy.minusMonths(2)
        const fechaRevision = Instrumento.revisiones.last().fechaRevision()
        return (fechaRevision > dosMesesAtras) 
    }
    method revisionesRecientes(){
        return revisiones.filter(self.revisionMenorADosMeses())
    }
}

class Revision {
    const property fechaRevision
    const property tecnico
}
class Fender inherits Instrumento {
    const color 

    override method estaAfinado()= true
    
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
    override method estaAfinado(){
        return temperatura.between(20,25)
    }

    override method afinar(){
        if(temperatura<25){
            self.calentarMetal()
            if(temperatura<25){
                self.calentarMetal()
                self.afinar()
            }
        }
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
    override method esCopado()= sordina
}

class Bechstein inherits Instrumento{
    var anchoSalon 
    var largoSalon
    method revisionDeFabrica(){
        self.registrarRevision(new Date(), "Fabrica")
    }
    
    override method estaAfinado(){
     const superficieSalon = anchoSalon * largoSalon
        return superficieSalon > 20
    }
    override method costo()= 2*anchoSalon
    override method esValioso() = self.estaAfinado()
    override method familia()="cuerdas"
    override method esCopado() = (anchoSalon>6||largoSalon>6)
    override method afinar(){
        anchoSalon=8
        largoSalon=4
    }
}

class Stagg inherits Instrumento{
    var tremolos = 0
    const property pintura  
    override method estaAfinado(){
        return tremolos<10
    }
    
    method hacerTremolo(){
        tremolos =tremolos + 1
    } 

    override method costo()=(20-tremolos).max(15)

    override method esValioso ()= pintura == "laca acrilica"
    override method familia()= "cuerdas"
    override method afinar(){
        tremolos=0
    }
}

class Generico inherits Instrumento {
    const familia
    override method familia()=familia
    override method costo()=familia.size()*self.multiplicador()
    method multiplicador(){
        const valorRandom = valorRandom.anyOne(1,10)
        if(valorRandom.even()) return 2
        else return 3
    }
    override method estaAfinado(){
        const fechaDeHoy = new Date()
        const fechaUltimaRevision = revisiones.last().fechaRevision()
        const limiteAfinacion = fechaDeHoy.minusMonths(1)
        return fechaUltimaRevision > limiteAfinacion             
    }
}
//2 los musicos 

class Musico { 
     var instrumento
     var preferencia
     method esExperto() = instrumento.familia()==preferencia
     method esFeliz()= instrumento.esCopado()
}
const trompetaJupiter = new Jupiter(temperatura = 22, sordina = false)
const pianoBechstein = new Bechstein(anchoSalon=5,largoSalon=5)
const guitarraFender = new Fender(color = "negro" )
const violinStagg = new Stagg (pintura ="laca acrilica" )
object johann inherits Musico(instrumento = trompetaJupiter,preferencia="vientos"){
    override method esFeliz() = instrumento.costo() >20
}

object wolfgang inherits Musico(instrumento = trompetaJupiter,preferencia="vientos"){
    override method esFeliz()=johann.esFeliz()
}

object antonio inherits Musico(instrumento = pianoBechstein,preferencia="vientos"){
    override method esFeliz()= instrumento.esValioso()
} 

object giuseppe inherits Musico(instrumento = guitarraFender,preferencia="vientos"){
  override method esFeliz()= instrumento.estaAfinado()
}
object maddalena inherits Musico(instrumento= violinStagg,preferencia="vientos"){
  override method esFeliz()= instrumento.costo().even()
}

//3 musicos y orquestas 
class Orquesta {
    var cantMaxMusicos
    var integrantes = #{}

    method agregarMusico(unMusico){
        if(integrantes.size()<cantMaxMusicos)
            integrantes.add(unMusico)
        else console.println("Banda completa")
    }

    method bienConformada(){
      integrantes.all({unIntegrante => unIntegrante.esFeliz()})
    }
}

//5 
class Tecnico {
    const nombre
    const especialistaEn = #{}

    method revision(instrumento){
        if((especialistaEn.contains(instrumento.familia()))
            && self.revisionMayorASemana(instrumento))
                instrumento.afinar()
                instrumento.registrarRevision(new Date(),nombre)
    }
    method revisionMayorASemana(instrumento){
        const fechaDeHoy = new Date()
        const unaSemanaAtras = fechaDeHoy.minusWeeks(1)
        const fechaUltimaRevision = Instrumento.revisiones.last().fechaRevision()
        return (fechaUltimaRevision > unaSemanaAtras) || Instrumento.revisiones.isEmpty()
    }
}

