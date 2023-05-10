<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Flying</title>
<style>
  .table-container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column; /* 수직 정렬을 위해 추가 */
    
  }

  table {
    border-collapse: separate;
    border-spacing: 10px;
    border: 1px solid black;
    border-radius: 10px;
  }

  td {
    width: 50px;
    height: 50px;
    text-align: center;
    border: 1px solid black;
    cursor: pointer;
    background-color: #34B680; /* 테이블 배경색 변경 */
    color: #fff; /* 테이블 숫자 색상 변경 */
  }

  td.selected {
    background-color: gray;
    color: white;
  }

  h1 {
    text-align: center;
  }

  .selected-seat {
    text-align: center;
    font-size: 24px;
    margin-top: 10px;
    background-color: #34B680;
    color: white;
    padding: 10px;
    border-radius: 15px;
  }
</style>

  <script>
    let selectedSeat = null;

    function selectSeat(seat) {
      if (selectedSeat !== null) {
        selectedSeat.classList.remove("selected");
      }

      selectedSeat = seat;
      selectedSeat.classList.add("selected");

      document.getElementById("selectedSeat").innerText = selectedSeat.innerText;
    }
    function completeReservation() {
      if (selectedSeat === null) {
        alert("좌석을 선택해주세요.");
      } else {
        // 좌석 예약 처리 및 예약 완료 페이지로 이동
        window.location.href = "reservation-complete.jsp";
      }
    }
  </script>

<body>
  <header>
    <jsp:include page="module/header.jsp" flush="false" />
  </header>

  <h1 style="margin-top:100px;">원하는 좌석을 선택해주세요</h1>

<div class="selected-seat-container" style="display: flex; justify-content: center; align-items: center; margin-top:0px;">
  <p class="selected-seat" style="font-size: 30px; background-color: #34B680; padding: 15px; border-radius: 15px; width: fit-content;">
    선택된 좌석: <span id="selectedSeat"></span>
  </p>
</div>
<div class="table-container">
  <table>
      <tr>
        <td onclick="selectSeat(this)">1</td>
        <td onclick="selectSeat(this)">2</td>
        <td onclick="selectSeat(this)">3</td>
        <td rowspan="2" style="background-color: transparent;"></td>
        <td onclick="selectSeat(this)">4</td>
      </tr>
      <tr>
        <td onclick="selectSeat(this)">6</td>
        <td onclick="selectSeat(this)">7</td>
        <td onclick="selectSeat(this)">8</td>
        <td onclick="selectSeat(this)">9</td>
      </tr>
      <tr>
        <td onclick="selectSeat(this)">10</td>
        <td onclick="selectSeat(this)">11</td>
        <td onclick="selectSeat(this)">12</td>
        <td onclick="selectSeat(this)">13</td>
        <td onclick="selectSeat(this)">14</td>
      </tr>
      <tr>
        <td onclick="selectSeat(this)">15</td>
        </tr>
          </table>
  </div>
<button onclick="completeReservation()" style="background-color: #34B680; font-size: 24px; padding: 15px 30px; border-radius: 10px; display: block; margin: 20px auto; text-align: center; color: white;">예약 완료</button>

</body>




  <footer>
    <jsp:include page="module/footer.jsp"/>
  </footer>
</body>
</html>