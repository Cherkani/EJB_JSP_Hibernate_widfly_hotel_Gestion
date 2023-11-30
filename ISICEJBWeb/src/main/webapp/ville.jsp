<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-ay2eApsZbY/uVKLr+Z8TO0JB58dRr5qV+zl2TpYY7ZlUV2HVGpr0/2W1uPg3LsR8SvMf8ViFA9OqnU5Lqj7U3ow==" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <!-- Your existing head content here -->
    
    <meta charset="UTF-8">
    <title>Filières List</title>
 <style>
  body {
    background-color: #F5F5DC;
}

.container {
    margin-top: 20px;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    border-radius: 5px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.data-table th,
.data-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.data-table th {
    background-color: #007bff;
    color: #fff;
}

.data-table tr:hover {
    background-color: #f5f5f5;
}

/* Alternating row colors */
.data-table tbody tr:nth-child(even) {
    background-color: #d1c0c0; /* Even row color */
}

.data-table tbody tr:nth-child(odd) {
    background-color: #ffffff; /* Odd row color */
}

.form-group {
    margin-bottom: 15px;
}

.form-label {
    font-weight: bold;
}

.input-group {
    display: flex;
    align-items: center;
}

.select-filter {
    flex-grow: 1;
    margin-right: 10px;
}

.btn {
    padding: 10px 20px;
    margin: 5px;
    cursor: pointer;
}

.btn-primary {
    background-color: #007bff;
    color: #fff;
}

</style>
</head>
<body>


<div class="container">
      <div class="container p-4 mt-4" style="border: 2px solid #d1c0c0; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="display-4">Gestion des villes</h1>



                <!-- Navigation Links to the Right -->
             <div class="ml-auto" style="display: flex; gap: 16px;">
    <a href="http://localhost:8080/ISICEJBWeb/HotelController" class="text-primary" style="text-decoration: none; display: flex; align-items: center; transition: all 0.3s;">
        <i class="fas fa-hotel" style="font-size: 24px; margin-right: 8px;"></i>
        <img src="https://cdn-icons-png.flaticon.com/512/5900/5900308.png" alt="Hotel" style="width: 40px; height: 40px; border-radius: 50%;" onerror="this.style.display='none';">
        <span style="font-size: 18px; margin-left: 8px;">Hotel</span>
    </a>

    <a href="http://localhost:8080/ISICEJBWeb/VilleController" class="text-primary" style="text-decoration: none; display: flex; align-items: center; transition: all 0.3s;">
        <i class="fas fa-hotel" style="font-size: 24px; margin-right: 8px;"></i>
        <img src="https://cdn-icons-png.flaticon.com/128/46/46326.png" alt="Hotel" style="width: 40px; height: 40px; border-radius: 50%;" onerror="this.style.display='none';">
        <span style="font-size: 18px; margin-left: 8px;">Ville</span>
    </a>
</div>

            </div>

        </div>


        <!-- Add ville Modal -->
        <div class="modal fade" id="villeModalCenter" tabindex="-1" role="dialog" aria-labelledby="villeModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="VilleController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="villeModalCenterTitle">Ajouter une ville</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                      
                            <label class="custom-modal-label" for="Name">Nom</label>
                            <input type="text" name="nom" class="form-control" required><br><br>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-success" value="Enregistrer">
                        </div>
                    </div>
                </form>
            </div>
        </div>

  <div class="modal fade" id="ModifyvilleModal" tabindex="-1" role="dialog" aria-labelledby="ModifyvilleModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="VilleController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModifyvilleModalTitle">Modifier une ville</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                          
                            <label class="custom-modal-label" for="Name">Nom</label>
                            <input type="text" name="nom" class="form-control" id="modalvilleName" required><br><br>

                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" id="modalvilleId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-success" value="Enregistrer">
                        </div>
                    </div>
                </form>
            </div>
        </div>

 <!--  voir tous les villes-->
  <table class="table data-table">
            <thead class="thead-light">
                <tr>
                    <th>ID</th>
                  
                    <th>Nom</th>
                    <th>supprimer</th>
                     <th>modifier</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${villes}" var="ville">
                    <tr>
                        <td>${ville.id}</td>
                     
                        <td>${ville.nom}</td>
                        <td>
                            <form action="VilleController" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${ville.id}">
                                <button type="submit" class="btn btn-danger">Supprimer</button>
                            </form>
                             </td>
                              <td >
                           <button type="button" class="btn btn-secondary ml-2" data-toggle="modal" data-target="#ModifyvilleModal" data-ville-id="${ville.id}" data-ville-name="${ville.nom}">
    Modifier
</button>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
             <div class="text-center">
          <a href="" ></a>
               
  <button type="button" class="btn btn-success" data-toggle="modal" data-target="#villeModalCenter">
                ajouter une ville
            </button>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script>
        $('#ModifyvilleModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var villeId = button.data('ville-id');          
            var villeName = button.data('ville-name');
            var modal = $(this);
            modal.find('#modalvilleName').val(villeName);          
            modal.find('#modalvilleId').val(villeId);
        });
    </script>


</body>
</html>