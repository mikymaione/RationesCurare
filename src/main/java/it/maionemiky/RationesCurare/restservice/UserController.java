package it.maionemiky.RationesCurare.restservice;

import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping(path = "/user")
public class UserController {

    private final UserRepository userRepository;

    public UserController(UserRepository ur) {
        this.userRepository = ur;
    }

    @GetMapping("/")
    public Iterable<UserEntity> findAll() {
        return userRepository.findAll();
    }

    @GetMapping("/{id}")
    public Optional<UserEntity> findById(@PathVariable Long id) {
        return userRepository.findById(id);
    }

    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable Long id) {
        userRepository.deleteById(id);
    }

    @PutMapping("/add")
    public void save(@RequestParam String cognome, @RequestParam String nome, @RequestParam String email) {
        userRepository.save(new UserEntity(cognome, nome, email));
    }

    @PutMapping("/update")
    public void update(@RequestParam Long id, @RequestParam String cognome, @RequestParam String nome, @RequestParam String email) {
        Optional<UserEntity> o = userRepository.findById(id);

        if (o.isPresent()) {
            UserEntity u = o.get();
            u.setCognome(cognome);
            u.setNome(nome);
            u.setEmail(email);

            userRepository.save(u);
        }
    }

}
