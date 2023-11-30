package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.IDaoLocalVille;
import entities.Ville;


@WebServlet("/VilleController")
public class VilleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private IDaoLocalVille ejb;
    public VilleController() {
        super();   
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		List<Ville> villeList = ejb.findAll();	
		System.out.println("listedesvillesdoGet : "+villeList);
		request.setAttribute("villes", villeList);
		request.getRequestDispatcher("/ville.jsp").forward(request, response);
		System.out.print("------------------------------------");
		System.out.print("get doget");
		System.out.print("------------------------------------");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 String action = request.getParameter("action");
        
	 
	 if ("delete".equals(action)) {
            int fieldId = Integer.parseInt(request.getParameter("id"));
            ejb.delete(ejb.findById(fieldId));
            System.out.print("-----------------------------------");
            System.out.print("Suppression DoPOST");
            System.out.print("-----------------------------------");
            response.sendRedirect(request.getContextPath() + "/VilleController");
		}

 

		else if ("edit".equals(action)) {
		    int id = Integer.parseInt(request.getParameter("id"));
		    String nom = request.getParameter("nom");
		    Ville villeToEdit = ejb.findById(id);
		    villeToEdit.setNom(nom);		    
		    ejb.update(villeToEdit);
		    System.out.print("-----------------------------------");
            System.out.print("edit DoPOST");
            System.out.print("-----------------------------------");
		    response.sendRedirect(request.getContextPath() + "/VilleController");
		}
		else if("showform".equals(action)) {
			try {
				showEditForm(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
		else {
	    String nom = request.getParameter("nom");
	  
	    Ville newField = new Ville(nom);
	    Ville creation = ejb.create(newField);
	    if (creation != null) {
		        List<Ville> Villes = ejb.findAll();
	            System.out.println(ejb.findAll());
		        request.setAttribute("villes", Villes);
		        System.out.print("-----------------------------------");
	            System.out.print("create DoPOST");
	            System.out.print("-----------------------------------");
		        request.getRequestDispatcher("/ville.jsp").forward(request, response);
		    } else {
		    	System.out.println("Failure: Field not created.");
		    }
	    }
	}
	
	
	
	private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Ville existingField = ejb.findById(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("editField.jsp");
		request.setAttribute("field", existingField);
		dispatcher.forward(request, response);
	
	}
		


}
