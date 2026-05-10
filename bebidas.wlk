import frutas.*
object whisky {
  method rendimientoQueOtorga(dosisConsumida) = 0.9 ** dosisConsumida
}

object terere {
  method rendimientoQueOtorga(dosisConsumida) = 1.max(0.1 * dosisConsumida)
}

object cianuro {
  method rendimientoQueOtorga(dosisConsumida) = 0
}

object licuado{
  const ingredientes = #{naranja, banana}

  method rendimientoQueOtorga(dosisConsumida) {
    return ingredientes.sum({f => f.nutrientes()}) * dosisConsumida
  }

  method agregar(ingrediente) {
    ingredientes.add(ingrediente)
  }
}

object aguaSaborizada{
  var otraBebida = whisky

  method otraBebida() = otraBebida

  method rendimientoQueOtorga(dosisConsumida) {
    return (agua.rendimientoQueOtorga(dosisConsumida)) + (otraBebida.rendimientoQueOtorga(dosisConsumida) * 0.25)
  }
 
  method cambiarBebida(bebida) {
    otraBebida = bebida
  }
 
}
object agua{
  method rendimientoQueOtorga(dosisConsumida) = 1
}
object coctel{
  const ingredientes = #{licuado, agua, aguaSaborizada, terere}

  method proporcionBebidas() = 1 / ingredientes.size()

  method rendimientoQueOtorga(dosisConsumida) {
    return ingredientes.fold(1, {rendimiento, bebida => rendimiento * bebida.rendimientoQueOtorga(dosisConsumida * self.proporcionBebidas()) })
  }
  method agregar(ingrediente) {
    ingredientes.add(ingrediente)
  }
}

