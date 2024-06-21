package yukay.com.ContactProfileApp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import yukay.com.ContactProfileApp.model.Contact;

@Repository
public interface ContactRepository extends JpaRepository<Contact, Long> {
}

