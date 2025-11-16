
    class Empleado {

        var habilidades = #{}
        var salud = 100
        var jerarquia  //NEW EMPLEADO O NEW OFICINISTA

        method habilidades() = habilidades
        method salud() = salud
        method estaIncapacitado(){
            return salud < self.saludCritica()
        }

        method saludCritica() = jerarquia.saludCritica()

        method usarHabilidad(unaHabilidad){
            self.validarIncapacidad()
            self.comprobarTenenciaHabilidad(unaHabilidad)

        }

        method validarIncapacidad(){
            if(self.estaIncapacitado()){
                throw new DomainException(message = "No puede usar habilidad, esta incapacitado")
            }
        }

        method comprobarTenenciaHabilidad(unaHabilidad){
            if(!self.posee(unaHabilidad)){
                throw new DomainException(message ="No tiene la habilidad")
            }
        }
        method posee(unaHabilidad){
            return habilidades.contains(unaHabilidad)
        }

        //pensar si vale la pena hacer una clase equipo
        method realizarMision(peligrosidadMision , habilidadesRequeridas){
            habilidadesRequeridas.all({habilidad => self.usarHabilidad(habilidad)})
            self.recibirDaño(peligrosidadMision)
            jerarquia.registrarMision(habilidadesRequeridas, self)
        }

        method sobrevivio() = salud > 0

        method recibirDaño(cuanto){
            salud -= cuanto
        }

        method aprenderHabilidad(unaHabilidad){
            habilidades.add(unaHabilidad)
        }

    }


    class Rol{

        method saludCritica(){}
    
        method validarRegistro(unasHabilidades, empleado){
            if(!empleado.sobrevivio()){
                throw new DomainException(message ="No ha sobrevivido a la mision. QEPD")
            }
        }

        method registrarMision(unasHabilidaddes, empleado){
            self.validarRegistro(unasHabilidaddes, empleado)
        }

    }
    class RolEspia inherits Rol  {

        override method saludCritica() = 15

        override method registrarMision(unasHabilidades, empleado){
            super(unasHabilidades, empleado)
            unasHabilidades.forEach({habilidad => empleado.aprenderHabilidad(habilidad)})
        }

    }

    class RolOficinista  inherits Rol{
        var estrellas

        override method saludCritica(){
            return self.nivelDeSaludCritica()
        }
        

        method nivelDeSaludCritica(){
            return 40-5*estrellas
        }

        override method registrarMision(unasHabilidades, empleado){
            super(unasHabilidades, empleado)
            self.ganarEstrella()
            self.comprobarAscenso()
        }

        method comprobarAscenso(){
            if(estrellas >= 3){
                self.ascender()
            }
        }
        method ganarEstrella() {estrellas += 1}


    }

    class Jefe inherits Empleado{
        var subordinados
        var rango // oficinista o espia

        override method posee(unaHabilidad){
            return subordinados.any({ empleado => empleado.posee(unaHabilidad)})
        }

        override method saludCritica(){
            return rango.saludCritica()
        }

    }

        class Equipo{
        //Polimorfico con empleados
        var integrantes

        method realizarMision(peligrosidadMision , habilidadesRequeridas){
            habilidadesRequeridas.all({ habilidad => self.algunoPuedeUsar(habilidad)})
            self.recibirDaño(peligrosidadMision / 3)
        }

        method algunoPuedeUsar(habilidad){
            return integrantes.any({integrante => integrante.posee(habilidad) && !integrante.estaIncapacitado()})
        }

        method recibirDaño(cuanto){
            integrantes.forEach({integrante => integrante.recibirDaño(cuanto)})
        }
    }