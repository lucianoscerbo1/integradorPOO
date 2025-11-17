class Expedicion{

    const objetivos //aldea capital o amurallada
    var vikingos

    var botinTotal

    method invadir(){
        objetivos.valeLaPena(self)
        objetivos.forEach({objetivo => objetivo.postInvasion(self)})

    }

    method cobrarVidas(){
        vikingos.forEach({vikingo => vikingo.matar()})
    }
    method valeLaPena(unaExpedicion){
        return objetivos.all({ objetivo => objetivo.valeLaPena(unaExpedicion)})
    }

    method cantidadVikingos(){
        return vikingos.size()
    }

    method sumarVikingo(unVikingo){
        vikingos.add(unVikingo)
    }

    method divisionBotin(unaExpedicion){
        return unaExpedicion.sumaBotin(unaExpedicion) / vikingos.size()
    }

    method sumaBotin(unaExpedicion){
       return objetivos.map({ objetivo => objetivo.botin(unaExpedicion)}).sum()
    }


    method repartirBotin(unaExpedicion){
        vikingos.forEach({vikingo => vikingo.aumentarOro(unaExpedicion.divisionBotin())})

    }

}

class Aldea{
    
    const cantidadCrucifijos

    method valeLaPena(unaExpedicion){
        if(!self.verificarLaPena(unaExpedicion)){
              throw new DomainException(message = "No vale la pena") 
        }
    }

    method  verificarLaPena(unaExpedicion) {
        return self.botin(unaExpedicion) >= 15
      
    }

    method botin(unaExpedicion){
        return cantidadCrucifijos
    }

    method postInvasion(unaExpedicion){
        unaExpedicion.cobrarVidas()
        unaExpedicion.repartirBotin(self.botin(unaExpedicion))
    }

}
class AldeaAmurallada inherits Aldea{

    const comitivaNecesaria

    override method verificarLaPena(unaExpedicion){
        return unaExpedicion.cantidadVikingos() > comitivaNecesaria
    }
}

class Capital{
    //hay la misma cantidad de defensores que de vikingos que atacan

    
    const factorRiqueza

    method valeLaPena(unaExpedicion){
        if(!self.verificarLaPena(unaExpedicion)){
            throw new DomainException(message = "No vale la pena")
        }

    }


    method postInvasion(unaExpedicion){
        unaExpedicion.cobrarVidas()
        unaExpedicion.repartirBotin(self.botin(unaExpedicion))
    }
    method verificarLaPena(unaExpedicion){
        return unaExpedicion.cantidadVikingos() <= 3 * self.botin(unaExpedicion)
    }
    method defensores(unaExpedicion){
        return unaExpedicion.cantidadVikingos()
    }

    method monedasDeOro(unaExpedicion){
        return self.defensores(unaExpedicion)
    }

    method botin(unaExpedicion){
        return self.monedasDeOro(unaExpedicion) * factorRiqueza
    }
}