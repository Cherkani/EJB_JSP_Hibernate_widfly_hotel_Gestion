package services;

import java.util.List;

import dao.IDaoLocalVille;
import dao.IDaoRemote;
import entities.Ville;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "aymenVille")
public class VilleService implements IDaoRemote<Ville>, IDaoLocalVille {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Ville create(Ville o) {
		em.persist(o);
		return o;
	}

	@Override
	public boolean delete(Ville o) {
	  
	    Ville mergedVille = em.merge(o);
	    
	 
	    em.remove(mergedVille);
	    
	    return true;
	}

	@Override
	public Ville update(Ville o) {
		// TODO Auto-generated method stub
		 Ville mergedVille = em.merge(o);
		 return mergedVille;
		 }

	@Override
	public Ville findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Ville.class, id);
	}

	@Override
	public List<Ville> findAll() {
		Query query = em.createQuery("select v from Ville v");
		return query.getResultList();
	}

}
