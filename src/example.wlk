
class Orden {
	
	const items = []
	
	method costoTotal() = items.sum { item => item.costo() }
 
 	method productosDelicados() =
 		items.filter { item => item.esDelicado() }
 			 .sortedBy { item1, item2 => item1.nombre() < item2.nombre() }
	
	method cantidadDe(nombreProducto) =
		items.filter { item => item.nombre() == nombreProducto }
			 .sum { item => item.cantidad() }
			 
	method productos() = items.map { item => item.producto() }
}


class Item {
	
	const property producto
	const property cantidad
	
	method costo() = producto.costo() * cantidad
	
	method esDelicado() = producto.esDelicado()
	
	method nombre() = producto.nombre()
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
	const property nombre = ""
	const pesoDelicado = 5
	
	/** Método abstracto */
	method costoProduccion() 
	
	/** Template Method */
	method costo() = self.costoProduccion() + 
						self.costoAlmacenaje()
						
	method costoAlmacenaje() = peso * valorAlmacenaje
	
	method esDelicado() = peso < pesoDelicado 
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

class Lote {
	
	const ordenes = []
	
	method cantidadDe(nombreProducto) = 
		ordenes.sum { orden => orden.cantidadDe(nombreProducto) }
	
	// La lista de productos que aparecen en un lote 
	// (o sea, aparecen en alguna orden del lote) ordenada por la 
	// cantidad total del producto en el lote.
	method productos() =
		ordenes.flatMap { orden => orden.productos() }
			   .withoutDuplicates()
			   .sortedBy { producto1, producto2 => 
			   		self.cantidadDe(producto1.nombre()) > 
			   			self.cantidadDe(producto2.nombre())
			   }
	
}











