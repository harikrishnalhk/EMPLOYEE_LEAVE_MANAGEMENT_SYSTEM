<%
    if (session.getAttribute("employee") == null) {
        response.sendRedirect("employeeLogin.jsp");
        return;
    }
%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>My Leave Requests</title>

<style>
/* ===== GLOBAL ===== */
body{
    margin:0;
    font-family:'Segoe UI', Arial, sans-serif;
    background:linear-gradient(135deg,#eef2f7,#dde6f3);
}

/* ===== PAGE TITLE ===== */
.page-title{
    text-align:center;
    margin:40px 0 10px;
    font-size:26px;
    font-weight:600;
    color:#2c3e50;
    animation:fadeDown 0.8s ease;
}

/* ===== CONTAINER ===== */
.table-container{
    width:85%;
    margin:30px auto 60px;
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 15px 35px rgba(0,0,0,0.12);
    animation:fadeUp 0.9s ease;
}

/* ===== TABLE ===== */
table{
    width:100%;
    border-collapse:collapse;
}

th, td{
    padding:14px 12px;
    text-align:center;
}

th{
    background:linear-gradient(135deg,#4f6ef7,#3b5bdb);
    color:white;
    font-weight:600;
}

tr{
    transition:0.25s ease;
}

tr:nth-child(even){
    background:#f8f9fc;
}

tr:hover{
    background:#eef3ff;
    transform:scale(1.01);
}

/* ===== STATUS STYLES ===== */
.status-approved{
    color:#27ae60;
    font-weight:600;
}

.status-rejected{
    color:#e74c3c;
    font-weight:600;
}

.status-pending{
    color:#f39c12;
    font-weight:600;
}

/* ===== EMPTY STATE ===== */
.empty{
    text-align:center;
    padding:30px;
    color:#777;
    font-size:16px;
}

/* ===== ANIMATIONS ===== */
@keyframes fadeUp{
    from{opacity:0; transform:translateY(30px);}
    to{opacity:1; transform:translateY(0);}
}

@keyframes fadeDown{
    from{opacity:0; transform:translateY(-20px);}
    to{opacity:1; transform:translateY(0);}
}
</style>
</head>

<body>

<%@ include file="employeeNavbar.jsp" %>

<div class="page-title">My Leave Requests</div>

<div class="table-container">

<table>
<tr>
    <th>Leave Type</th>
    <th>From Date</th>
    <th>To Date</th>
    <th>Status</th>
    <th>Rejection Reason</th>
</tr>

<c:forEach var="l" items="${leaves}">
<tr>
    <td>${l.type}</td>
    <td>${l.fromDate}</td>
    <td>${l.toDate}</td>

    <td>
        <c:choose>
            <c:when test="${l.status == 'APPROVED'}">
                <span class="status-approved">APPROVED</span>
            </c:when>
            <c:when test="${l.status == 'REJECTED'}">
                <span class="status-rejected">REJECTED</span>
            </c:when>
            <c:otherwise>
                <span class="status-pending">PENDING</span>
            </c:otherwise>
        </c:choose>
    </td>

    <td>${l.rejectionReason}</td>
</tr>
</c:forEach>

<c:if test="${empty leaves}">
<tr>
    <td colspan="5" class="empty">
        No leave requests found
    </td>
</tr>
</c:if>

</table>

</div>

</body>
</html>
