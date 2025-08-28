package br.com.dunnas.desafio.sistemaaluguel.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.dunnas.desafio.sistemaaluguel.model.Usuario;
import br.com.dunnas.desafio.sistemaaluguel.repository.UsuarioRepository;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    /**
     * Autentica um utilizador com base no e-mail e na senha.
     * AVISO: Este método compara senhas em texto puro e só deve ser usado
     * para fins de desenvolvimento, enquanto o Spring Security está desativado.
     *
     * @param email o e-mail do utilizador.
     * @param senha a senha em texto puro.
     * @return o objeto Usuario se a autenticação for bem-sucedida.
     * @throws RuntimeException se as credenciais forem inválidas.
     */
    public Usuario autenticar(String email, String senha) {
        // Busca o utilizador pelo e-mail
        Usuario usuario = usuarioRepository.findByEmail(email)
            .orElseThrow(() -> new RuntimeException("Credenciais inválidas.")); 

        // Compara a senha fornecida com a senha guardada no banco (em texto puro)
        if (usuario.getSenha().equals(senha)) {
            return usuario; // Retorna o utilizador se a senha corresponder
        } else {
            throw new RuntimeException("Credenciais inválidas."); // Lança uma exceção se a senha não corresponder
        }
    }

    /**
     * Regista um novo utilizador no sistema.
     * AVISO: Este método guarda a senha em texto puro.
     *
     * @param usuario O objeto Usuario com os dados para o registo.
     * @return o objeto Usuario salvo.
     * @throws RuntimeException se o e-mail já estiver em uso.
     */
    public Usuario registrarUsuario(Usuario usuario) {
        // 1. Verifica se o e-mail já está em uso para evitar duplicatas
        if (usuarioRepository.findByEmail(usuario.getEmail()).isPresent()) {
            throw new RuntimeException("Erro: O e-mail informado já está em uso.");
        }

        // 2. Guarda o utilizador no banco de dados
        return usuarioRepository.save(usuario);
    }

    /**
     * Busca um utilizador pelo seu ID.
     *
     * @param id o ID do utilizador.
     * @return um Optional contendo o utilizador, se encontrado.
     */
    public Optional<Usuario> buscarPorId(Integer id) {
        return usuarioRepository.findById(id);
    }

    /**
     * Lista todos os utilizadores registados no sistema.
     *
     * @return uma lista de todos os utilizadores.
     */
    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }
}