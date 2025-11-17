class Vikingo{
    var ocupacion
    var oro
    method oro() = oro
    method aumentarOro(cuanto){
        oro += cuanto
    }

    method esProductivo(){
        return ocupacion.esProductivo()
    }

    method suOcupacion()= ocupacion

    method puedeExcursionar(){
       if(!self.esProductivo()){
            throw new DomainException(message="Este vikingo no puede subir")
       }

    }

    method subirseA(unaExpedicion){
        self.esProductivo()
        unaExpedicion.sumarVikingo(self)
    }

    method matar(){
        return ocupacion.matar()
    }
}
