
class Orden {
	
	const items
	
	method costoTotal() = items.sum{ item => item.costo() }
	
}


class Item {
	
	const producto
	const cantidad
	
	method costo() = producto.costo() * cantidad
	
}

object productoComprado {
	
	const property indiceTraslado = 1.2
	
}

/** Producto es Clase Abstracta 
Producto es SUPERCLASE de Producto Comprado, Producto Conservado....etc
*/
class Producto { 
	
	const peso
	const valorAlmacenaje
	
	/** Método abstracto */
	method costoProduccion() 
	
	/** Template Method */
	method costo() = self.costoProduccion() + 
						self.costoAlmacenaje()
						
	method costoAlmacenaje() = peso * valorAlmacenaje 
}

/** Producto Comprado ES UN Producto  
Producto Comprado es SUBCLASE de Producto
*/
class ProductoComprado inherits Producto { 
	
	const precioCompra
	
	override method costoProduccion() = precioCompra
	
	override method costoAlmacenaje() = super() * 
						productoComprado.indiceTraslado()
	
}

class ProductoConservado inherits Producto {
	
	const precioCompra
	var diasConservacion
	
	override method costoProduccion() = precioCompra + 
		(diasConservacion * peso * 
			productoConservado.costoConservacion()) 
						
}

object productoConservado {
	
	const property costoConservacion = 100
	
} 


class ProductoFabricado inherits Producto {
	
	const cantidadHsTrabajo
	
	override method costoProduccion() = cantidadHsTrabajo * 
							productoFabricado.costoHsTrabajo()
}

object productoFabricado {
	
	const property costoHsTrabajo = 500
	
}

