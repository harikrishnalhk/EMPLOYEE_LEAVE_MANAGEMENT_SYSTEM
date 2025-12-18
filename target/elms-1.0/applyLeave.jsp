<%
    if (session.getAttribute("employee") == null) {
        response.sendRedirect("employeeLogin.jsp");
        return;
    }
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Apply Leave</title>

<style>
/* ===== GLOBAL ===== */
body{
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    margin: 0;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* ===== FORM CARD ===== */
.form-box{
    width: 500px;
    background: #ffffff;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.15);
    animation: slideUp 0.8s ease;
    position: relative;
}

/* ===== ANIMATION ===== */
@keyframes slideUp{
    from{
        opacity: 0;
        transform: translateY(40px);
    }
    to{
        opacity: 1;
        transform: translateY(0);
    }
}

h2{
    text-align: center;
    margin-bottom: 30px;
    color: #333;
    font-weight: 700;
    font-size: 32px;
    text-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

/* ===== INPUTS ===== */
input, select, textarea{
    width: 100%;
    padding: 15px;
    margin: 10px 0;
    border: 2px solid #e1e5e9;
    border-radius: 10px;
    font-size: 16px;
    transition: all 0.3s ease;
    box-sizing: border-box;
}

input:focus, select:focus, textarea:focus{
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    transform: translateY(-2px);
}

/* ===== RADIO BUTTONS ===== */
.duration-options {
    display: flex;
    justify-content: space-around;
    margin: 20px 0;
}

.duration-options label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-size: 16px;
    color: #555;
}

.duration-options input[type="radio"] {
    margin-right: 8px;
    accent-color: #667eea;
}

/* ===== FILE INPUT ===== */
#documentDiv {
    margin-top: 15px;
    padding: 15px;
    border: 2px dashed #ddd;
    border-radius: 10px;
    background: #f9f9f9;
    display: none;
}

#documentDiv input[type="file"] {
    margin-bottom: 5px;
}

#documentDiv small {
    color: #666;
    font-size: 14px;
}

/* ===== BUTTON ===== */
button{
    width: 100%;
    padding: 15px;
    margin-top: 20px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 18px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

button:hover{
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

button:active {
    transform: translateY(-1px);
}

/* ===== MESSAGES ===== */
.success, .error {
    text-align: center;
    margin-top: 20px;
    padding: 12px;
    border-radius: 8px;
    font-weight: 500;
    animation: fadeIn 0.6s ease;
}

.success {
    color: #27ae60;
    background: #d4edda;
    border: 1px solid #c3e6cb;
}

.error {
    color: #e74c3c;
    background: #f8d7da;
    border: 1px solid #f5c6cb;
}

@keyframes fadeIn{
    from{opacity: 0; transform: translateY(10px);}
    to{opacity: 1; transform: translateY(0);}
}

/* ===== RESPONSIVE ===== */
@media (max-width: 600px) {
    .form-box {
        width: 90%;
        padding: 30px 20px;
    }
    
    .duration-options {
        flex-direction: column;
        gap: 10px;
    }
}
</style>
</head>

<body>

<%@ include file="employeeNavbar.jsp" %>

<div class="form-box">
    <h2>Apply Leave</h2>

    <form action="applyLeave" method="post" enctype="multipart/form-data">

        <select name="type" id="leaveType" required onchange="toggleDocument()">
            <option value="">-- Select Leave Type --</option>
            <option value="CASUAL">Casual Leave</option>
            <option value="SICK">Sick Leave</option>
            <option value="EARNED">Earned Leave</option>
            <c:if test="${gender == 'Female'}">
                <option value="MATERNITY">Maternity Leave</option>
            </c:if>
            <option value="UNPAID">Unpaid Leave</option>
        </select>

        <input type="date" name="fromDate" id="fromDate" required min="<%= java.time.LocalDate.now() %>" onchange="checkDates()">
        <input type="date" name="toDate" id="toDate" required min="<%= java.time.LocalDate.now() %>" onchange="checkDates()">

        <div class="duration-options">
            <label><input type="radio" name="duration" value="FULL" checked> Full Day</label>
            <label><input type="radio" name="duration" value="FIRST"> Half Day - First Half</label>
            <label><input type="radio" name="duration" value="SECOND"> Half Day - Second Half</label>
        </div>

        <textarea name="reason" placeholder="Reason for leave" rows="4" required></textarea>

        <div id="documentDiv" style="display:none;">
            <input type="file" name="document" accept=".pdf,.jpg,.png">
            <small>Medical certificate required for sick leave exceeding two days.</small>
        </div>

        <button type="submit">Apply Leave</button>
    </form>

    <!-- ✅ SUCCESS MESSAGE -->
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>

    <!-- ❌ ERROR MESSAGE -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
</div>

<script>
function toggleDocument() {
    const type = document.getElementById('leaveType').value;
    const div = document.getElementById('documentDiv');
    div.style.display = (type === 'SICK') ? 'block' : 'none';
    checkDays();
}

function checkDays() {
    const from = document.getElementById('fromDate').value;
    const to = document.getElementById('toDate').value;
    const type = document.getElementById('leaveType').value;
    const div = document.getElementById('documentDiv');
    if (type === 'SICK' && from && to) {
        const start = new Date(from);
        const end = new Date(to);
        const days = Math.ceil((end - start) / (1000 * 60 * 60 * 24)) + 1;
        div.style.display = (days > 2) ? 'block' : 'none';
    }
}

function checkDates() {
    const fromDate = document.getElementById('fromDate').value;
    const toDate = document.getElementById('toDate').value;
    if (fromDate && toDate) {
        const start = new Date(fromDate);
        const end = new Date(toDate);
        if (end < start) {
            alert('End date cannot be before start date.');
            document.getElementById('toDate').value = fromDate;
        }
    }
}
</script>

</body>
</html>
