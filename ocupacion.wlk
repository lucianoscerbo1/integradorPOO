class Soldado {

    var armas // se habla solo de cantidad
    var victimas

    method esProductivo(){
        return self.tieneArmas() and self.esAsesino()
    }

    method matar(){
        victimas +=1
    }
    method tieneArmas(){
       return armas > 0
    }
    method esAsesino() = victimas > 20

    method beneficiosDeAscenso(){
        armas +=10
    }
}

class Granjero{
    var hijos
    var hectareasDesignadas

    method beneficiosDeAscenso(){
        hijos +=2
        hectareasDesignadas +=2
    }
    method tieneArmas() = false

    method esProductivo(){
        return self.verificarProductividad()
        
    }

    method verificarProductividad(){
        // necesita al menos 2 hectareas por hijo
        return hectareasDesignadas >= hijos *2
    }
}