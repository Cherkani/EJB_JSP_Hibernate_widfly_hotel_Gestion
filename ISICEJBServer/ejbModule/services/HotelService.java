package services;

import java.util.List;

import dao.IDaoLocalHotel;
import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;


@Stateless(name="aymenHotel")
public class HotelService implements IDaoRemote<Hotel>,IDaoLocalHotel{
@PersistenceContext
private EntityManager em;

public Hotel create(Hotel o) {
	em.persist(o);
	return o;
}
public Hotel update(Hotel o) {
	Hotel mergedHotel = em.merge(o);
	
	return mergedHotel;
	
}
public boolean delete(Hotel o) {
    Hotel mergedHotel = em.merge(o);
    
	 
    em.remove(mergedHotel);
	
	
	return true;
}
@Override
public Hotel findById(int id) {
return em.find(Hotel.class,id);
}
@Override
public List<Hotel> findAll() {
	
	Query query= em.createQuery("select h from Hotel h");	
	return query.getResultList();
}


@Override
public List<Hotel> findByVilleId(int villeId) {
    Query query = em.createQuery("select h from Hotel h where h.ville.id = :id");
    query.setParameter("id", villeId);

    List<Hotel> resultList = query.getResultList();

    return resultList.isEmpty() ? null : resultList;
}
	
	
}

