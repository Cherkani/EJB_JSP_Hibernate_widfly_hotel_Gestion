package controllers;

import java.io.IOException;
import java.util.List;

import dao.IDaoLocalHotel;
import dao.IDaoLocalVille;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.HotelService;
import entities.Hotel;
import entities.Ville;
@WebServlet("/HotelController")
public class HotelController extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	@EJB
	private IDaoLocalHotel hdao;
@EJB
private IDaoLocalVille vdao;

    public HotelController() {
        super();   
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		List<Hotel> HotelList = hdao.findAll();	
		List<Ville> villesList = vdao.findAll();
		System.out.println("liste : "+villesList);
		request.setAttribute("hotels", HotelList);
		request.setAttribute("villes", villesList);
		request.getRequestDispatcher("/Hotel.jsp").forward(request, response);
	}	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			  
		    int HotelId = Integer.parseInt(request.getParameter("id"));
		    System.out.print("-----------------------------------");
            System.out.print("delete DoPOST");
            System.out.print("valeurs "+HotelId);
            System.out.print("-----------------------------------");
		    if(hdao.findById(HotelId)!=null) {
		    	Hotel Hoteldelete =  hdao.findById(HotelId);
		    	Hoteldelete.setVille(null);
		        Hotel updated = hdao.update(Hoteldelete);
		        System.out.println("-----------------------------------");
		        System.out.println("-----------------------------------");
		        System.out.println("valeurs updated "+updated);
		        System.out.println("valeurs updated "+Hoteldelete);
		        System.out.println("-----------------------------------");
		        System.out.println("-----------------------------------");
		     
		        if (updated !=null) {
		            hdao.delete(updated);
		            boolean deleted = true;
		            if (deleted) {
		                response.sendRedirect(request.getContextPath() + "/HotelController");
		            } else {
		                response.sendRedirect(request.getContextPath() + "/HotelController?deleteFailed=true");
		            }
		        }
		    }
		}

		else if("edit".equals(action)) {
			   System.out.print("-----------------------------------");
	            System.out.print("edit DoPOST");
	            System.out.print("-----------------------------------");
	        int id = Integer.parseInt(request.getParameter("id"));
	        String adresse = request.getParameter("adresse");
			String nom = request.getParameter("nom");
			String tele = request.getParameter("telephone");
			int ville_id =Integer.parseInt(request.getParameter("ville")) ;
			Ville ville = vdao.findById(ville_id);
	        Hotel HotelToEdit = hdao.findById(id);
	        if (HotelToEdit != null) {
	        	HotelToEdit.setAdresse(adresse);
	        	HotelToEdit.setNom(nom);
	        	HotelToEdit.setTelephone(tele);
	         	HotelToEdit.setVille(ville);
	            hdao.update(HotelToEdit);
	        }
	        response.sendRedirect(request.getContextPath() + "/HotelController");
	    }
		
		
		
		
		
		else if ("filterByVille".equals(action)) {
		    String filterVilleParam = request.getParameter("filterVille");

		    // Check if the parameter is not null and not empty
		    if (filterVilleParam != null && !filterVilleParam.isEmpty()) {
		        try {
		            int villeId = Integer.parseInt(filterVilleParam);

		            List<Hotel> hotelList;
		            if (villeId == 0) {
		                hotelList = hdao.findAll();
		            } else {
		                hotelList = hdao.findByVilleId(villeId);
		            }

		            List<Ville> villeList = vdao.findAll();

		            request.setAttribute("hotels", hotelList);
		            request.setAttribute("villes", villeList);
		        } catch (NumberFormatException e) {
		            // Handle the case where the parameter cannot be parsed to an integer
		            e.printStackTrace(); // or log the error
		        }
		    }

		    request.getRequestDispatcher("/Hotel.jsp").forward(request, response);
		}


		else if("addVille".equals(action)) {
			   System.out.print("-----------------------------------");
	            System.out.print("addville DoPOST");
	            System.out.print("-----------------------------------");
			int etdId = Integer.parseInt(request.getParameter("villeId"));
			int VilleId = Integer.parseInt(request.getParameter("Ville"));
			Hotel etd = hdao.findById(etdId);
			Ville Ville = vdao.findById(VilleId);
			System.out.println(etd);
			System.out.println(Ville);
			
			etd.setVille(Ville);
			hdao.update(etd);
			response.sendRedirect(request.getContextPath() + "/HotelController");
		}
		
		// ...

		else {
		    String adresse = request.getParameter("adresse");
		    String nom = request.getParameter("nom");
		    String telephone = request.getParameter("telephone");
		    int villeId = Integer.parseInt(request.getParameter("ville"));

		    Ville v = vdao.findById(villeId);
		    Hotel newHotel = new Hotel(adresse, nom, telephone, v);

		    System.out.print("-----------------------------------");
		    System.out.print("else - add - DoPOST");
		    System.out.print("valeurs :" + " " + adresse + " " + nom + " " + telephone + " " + villeId);
		    System.out.print("-----------------------------------");

		    Hotel hotelStopcreate = hdao.create(newHotel);
		    
		    if (hotelStopcreate != null) {
		        // Rediriger après le traitement réussi du formulaire
		        response.sendRedirect(request.getContextPath() + "/HotelController");
		    } else {
		        System.out.println("Failure: Hotel not created.");
		    }
		}

	}
	
}
