<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Admin – Leave Requests</title>

<style>
/* ===== BACKGROUND ===== */
body {
    font-family: "Segoe UI", Arial;
    background: linear-gradient(120deg, #667eea, #764ba2);
    min-height: 100vh;
}

/* ===== CONTAINER ===== */
.container {
    width: 92%;
    margin: 40px auto;
    background: #ffffff;
    padding: 25px;
    border-radius: 14px;
    box-shadow: 0 25px 45px rgba(0,0,0,0.2);
    animation: fadeUp 0.8s ease;
}

/* ===== ANIMATION ===== */
@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(25px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* ===== TITLE ===== */
h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #2c3e50;
    font-size: 26px;
}

/* ===== TABLE ===== */
table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 12px;
    overflow: hidden;
}

/* ===== HEADER ===== */
th {
    background: linear-gradient(90deg, #2c3e50, #34495e);
    color: white;
    padding: 14px;
    font-size: 14px;
    text-transform: uppercase;
}

/* ===== CELLS ===== */
td {
    padding: 14px;
    text-align: center;
    font-size: 14px;
    color: #2c3e50;
}

/* ===== ROW STYLING ===== */
tr:nth-child(even) {
    background: #f7f9fc;
}

tbody tr {
    transition: all 0.25s ease;
}

tbody tr:hover {
    background: #eef2ff;
    transform: scale(1.01);
}

/* ===== STATUS BADGES ===== */
.status-approved {
    color: #28a745;
    font-weight: bold;
}

.status-rejected {
    color: #dc3545;
    font-weight: bold;
}

.status-pending {
    color: #ff9800;
    font-weight: bold;
}

/* ===== ACTION ROW ===== */
.action-row {
    display: flex;
    gap: 8px;
    justify-content: center;
    align-items: center;
}

/* ===== BUTTONS ===== */
button {
    padding: 7px 14px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    transition: all 0.25s ease;
}

.approve {
    background: linear-gradient(90deg, #28a745, #3ddc84);
    color: white;
}

.approve:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 15px rgba(40,167,69,0.4);
}

.reject {
    background: linear-gradient(90deg, #dc3545, #ff6b6b);
    color: white;
}

.reject:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 15px rgba(220,53,69,0.4);
}

/* ===== INPUT ===== */
input[type="text"] {
    padding: 6px;
    width: 140px;
    border-radius: 6px;
    border: 1px solid #ccc;
    transition: all 0.2s ease;
}

input[type="text"]:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 2px rgba(102,126,234,0.2);
}
</style>
</head>

<body>

<!-- ✅ NAVBAR -->
<%@ include file="adminNavbar.jsp" %>

<div class="container">
    <h2>Leave Requests</h2>

    <table>
        <tr>
            <th>Email</th>
            <th>Type</th>
            <th>From</th>
            <th>To</th>
            <th>Reason</th>
            <th>Status</th>
            <th>Rejection Reason</th>
            <th>Action</th>
        </tr>

        <c:forEach var="l" items="${leaves}">
            <tr>
                <td>${l.email}</td>
                <td>${l.type}</td>
                <td>${l.fromDate}</td>
                <td>${l.toDate}</td>
                <td>${l.reason}</td>

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

                <td>
                    <c:if test="${l.status == 'PENDING'}">
                        <div class="action-row">

                            <!-- APPROVE -->
                            <form action="leaveAction" method="post">
                                <input type="hidden" name="id" value="${l.id}">
                                <input type="hidden" name="action" value="APPROVE">
                                <button type="submit" class="approve">Approve</button>
                            </form>

                            <!-- REJECT -->
                            <form action="leaveAction" method="post">
                                <input type="hidden" name="id" value="${l.id}">
                                <input type="hidden" name="action" value="REJECT">
                                <input type="text" name="reason" placeholder="Reject reason" required>
                                <button type="submit" class="reject">Reject</button>
                            </form>

                        </div>
                    </c:if>
                </td>
            </tr>
        </c:forEach>

    </table>
</div>

</body>
</html>
