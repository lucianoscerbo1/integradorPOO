import vikingos.*
class Jarl inherits Vikingo{

    override method puedeExcursionar(){
        if(!self.esProductivo() && self.suOcupacion().tieneArmas()){
            throw new DomainException(message= "Este vikingo no puede subir")
        }
    }

    method ascenderSocialmente(){
        self.subirDeClase()
        ocupacion.beneficiosDeAscenso()
        
    }

    method subirDeClase(){
        return new Karl(ocupacion = self.suOcupacion(), oro = self.oro())
    }
}

class Karl inherits Vikingo{

    method ascenderSocialmente(){
        self.subirDeClase()
        ocupacion.beneficiosDeAscenso()
    }
    method subirDeClase(){
        return new Thrall(ocupacion = self.suOcupacion(), oro=self.oro())
    }


}

class Thrall inherits Vikingo{

}