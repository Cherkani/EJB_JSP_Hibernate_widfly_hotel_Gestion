<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
     <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-ay2eApsZbY/uVKLr+Z8TO0JB58dRr5qV+zl2TpYY7ZlUV2HVGpr0/2W1uPg3LsR8SvMf8ViFA9OqnU5Lqj7U3ow==" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <title>Gestion des étudiants</title>
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
                  <h1 class="display-4">Gestion des Hotels</h1>
        
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

<form action="HotelController" method="post" class="mb-4">
    <div class="form-group">
        <label for="filterVille" class="form-label">Filtrage par Ville:</label>
        <div class="input-group">
            <select name="filterVille" class="form-control">
                <option value="0">All</option>
                <c:forEach items="${villes}" var="ville">
                    <option value="${ville.id}">${ville.nom}</option>
                </c:forEach>
            </select>
            <input type="hidden" name="action" value="filterByVille">
            <button type="submit" class="btn btn-primary">Filter</button>
        </div>
    </div>
</form>

      
        
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="HotelController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">Ajouter un Hotel</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="adresse">adresse:</label>
                            <input type="text" name="adresse" class="form-control" required><br><br>

                        
                            <label class="custom-modal-label" for="nom">nom</label>
                            <input type="text" name="nom" class="form-control" required><br><br>

                            <label class="custom-modal-label" for="telephone">telephone</label>
                            <input type="text" name="telephone" class="form-control" required><br><br>

                            <label class="custom-modal-label" for="ville">Ville:</label>
                            <select name="ville" class="form-control" required>
                                <c:forEach items="${villes}" var="ville">
                                    <option value="${ville.id}">${ville.nom}</option>
                                </c:forEach>
                            </select>
                            
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-success" value="Save">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="modal fade" id="ModifyStudentModal" tabindex="-1" role="dialog" aria-labelledby="ModifyStudentModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="HotelController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModifyStudentModalTitle">Modifier un hotel</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="adresse">adresse:</label>
                            <input type="text" name="adresse" class="form-control" id="modalStudentadresse" required><br><br>

                            <label class="custom-modal-label" for="nom">nom:</label>
                            <input type="text" name="nom" class="form-control" id="modalStudentnom" required><br><br>

                            <label class="custom-modal-label" for="telephone">Telephone:</label>
                            <input type="text" name="telephone" class="form-control" id="modalStudentTelephone" required><br><br>

                            <label class="custom-modal-label" for="ville">ville:</label>
                            <select name="ville" class="form-control" id="modalStudentville" required>
                                <c:forEach items="${villes}" var="ville">
                                    <option value="${ville.id}">${ville.nom}</option>
                                </c:forEach>
                            </select>

                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" id="modalStudentId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-success" value="Save Changes">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        
<!--  <div class="modal fade" id="AssignVilleModal" tabindex="-1" role="dialog" aria-labelledby="AssignRoleModalTitle" aria-hidden="true"> -->
<!--             <div class="modal-dialog modal-dialog-centered" role="document"> -->
<!--                 <form action="EtudiantController" method="post"> -->
<!--                     <div class="modal-content"> -->
<!--                         <div class="modal-header"> -->
<!--                             <h5 class="modal-title" id="AssignRoleModalTitle">affectation de Restaurent a une Ville</h5> -->
<!--                             <button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!--                                 <span aria-hidden="true">&times;</span> -->
<!--                             </button> -->
<!--                         </div> -->
<!--                         <div class="modal-body"> -->
<!--                             <label class="custom-modal-label" for="role">Choisir une ville:</label> -->
<!--                             <select name="role" class="form-control" required> -->
<%--                                 <c:forEach items="${villes}" var="ville"> --%>
<%--                                     <option value="${ville.id}">${ville.nom}</option> --%>
<%--                                 </c:forEach> --%>
<!--                             </select> -->

<!--                             <input type="hidden" name="action" value="addVille"> -->
<!--                             <input type="hidden" name="id" id="modalStudentId"> -->
<!--                             <input type="hidden" name="villeId" id="modalAssignVilleId"> -->
<!--                         </div> -->
<!--                         <div class="modal-footer"> -->
<!--                             <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> -->
<!--                             <input type="submit" class="btn btn-primary" value="Affectation ville"> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </form> -->
<!--             </div> -->
<!--         </div> -->
       <table class="table data-table">
    <thead class="thead-light">
        <tr>
            <th>ID</th>
            <th>Adresse</th>
            <th>Nom</th>
            <th>Telephone</th>
            <th>Ville</th>
            <th>Supprimer</th>
            <th>Modifier</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${hotels}" var="hotel">
            <tr>
                <td>${hotel.id}</td>
                <td>${hotel.adresse}</td>
                <td>${hotel.nom}</td>
                <td>${hotel.telephone}</td>
                <td>${hotel.ville.nom}</td>
                <td>
                    <form action="HotelController" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${hotel.id}">
                        <button type="submit" class="btn btn-danger">Supprimer</button>
                    </form>
                </td>
                <td>
                    <button type="button" class="btn btn-secondary ml-2" data-toggle="modal" data-target="#ModifyStudentModal"
                            data-student-id="${hotel.id}" data-student-adresse="${hotel.adresse}"
                             data-student-nom="${hotel.nom}"
                            data-student-telephone="${hotel.telephone}" data-student-ville="${hotel.ville}">
                        Modifier
                    </button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
        <div class="text-center">
         <a href="" ></a>
        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModalCenter">
                Ajouter un étudiant
            </button>
    </div>
  </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script>
        $('#ModifyStudentModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var studentId = button.data('student-id');
            var studentadresse = button.data('student-adresse');


            var studentnom = button.data('student-nom');
            var studentTelephone = button.data('student-telephone');
            var studentville = button.data('student-ville');
            var modal = $(this);

            modal.find('#modalStudentadresse').val(studentadresse);
          
            modal.find('#modalStudentnom').val(studentnom);
            modal.find('#modalStudentTelephone').val(studentTelephone);
            modal.find('#modalStudentville').val(studentville);
            modal.find('#modalStudentId').val(studentId);
        });

        $('#AssignVilleModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var villetId = button.data('ville-id');
            var modal = $(this);

            modal.find('#modalAssignVilleId').val(villetId);
        });
 </script>
</body>
</html>
