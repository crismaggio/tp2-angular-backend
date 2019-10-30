package dominio

class BusinessException extends RuntimeException {

	new(String msg) {
		super(msg)
	}
}

class RepositorioException extends RuntimeException {

	new(String msg) {
		super(msg)
	}

}
