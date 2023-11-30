import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import jakarta.persistence.ManyToOne;

public class TestHotel {
	public static IDaoRemote<Ville> lookUpEmployeRemoteVille() throws NamingException {
		final Hashtable<String, String> jndiProperties = new Hashtable<String, String>();
		jndiProperties.put(Context.INITIAL_CONTEXT_FACTORY, "org.wildfly.naming.client.WildFlyInitialContextFactory");
		jndiProperties.put(Context.PROVIDER_URL, "http-remoting://localhost:8080");
final Context context = new InitialContext(jndiProperties);

		return (IDaoRemote<Ville>) context.lookup("ejb:ISICEJBEAR/ISICEJBServer/aymenVille!dao.IDaoRemote");

	}
	public static IDaoRemote<Hotel> lookUpEmployeRemoteHotel() throws NamingException {
		final Hashtable<String, String> jndiProperties = new Hashtable<String, String>();
		jndiProperties.put(Context.INITIAL_CONTEXT_FACTORY, "org.wildfly.naming.client.WildFlyInitialContextFactory");
		jndiProperties.put(Context.PROVIDER_URL, "http-remoting://localhost:8080");
final Context context = new InitialContext(jndiProperties);

		return (IDaoRemote<Hotel>) context.lookup("ejb:ISICEJBEAR/ISICEJBServer/aymenHotel!dao.IDaoRemote");

	}
	public static void main(String[] args) {
	    try {
	        IDaoRemote<Ville> daoVille = lookUpEmployeRemoteVille();
	        Ville ville_id1 = daoVille.findById(1);
System.out.print(ville_id1);
IDaoRemote<Hotel> daoHotel = lookUpEmployeRemoteHotel();
daoHotel.create(new Hotel("hotel_1", "adresse_1", "0606060606",ville_id1));

for (Hotel hotel : daoHotel.findAll()) {
    System.out.println(hotel.getNom());
}
	       
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	

	
}
