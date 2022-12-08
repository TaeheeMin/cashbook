<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/NewFile.css">
	</head>
	
	<body>
		<div class="wrapper">
  <main>
    <div class="toolbar">
      <div class="current-month">June 2016</div>
      <div class="search-input">
        <input type="text" value="What are you looking for?">
        <i class="fa fa-search"></i>
      </div>
    </div>
    <div class="calendar">
      <div class="calendar__header">
        <div>mon</div>
        <div>tue</div>
        <div>wed</div>
        <div>thu</div>
        <div>fri</div>
        <div>sat</div>
        <div>sun</div>
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">1</div>
        <div class="calendar__day day">2</div>
        <div class="calendar__day day">3</div>
        <div class="calendar__day day">4</div>
        <div class="calendar__day day">5</div>
        <div class="calendar__day day">6</div>
        <div class="calendar__day day">7</div>
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">8</div>
        <div class="calendar__day day">9</div>
        <div class="calendar__day day">10</div>
        <div class="calendar__day day">11</div>
        <div class="calendar__day day">12</div>
        <div class="calendar__day day">13</div>
        <div class="calendar__day day">14</div>        
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">15</div>
        <div class="calendar__day day">16</div>
        <div class="calendar__day day">17</div>
        <div class="calendar__day day">18</div>
        <div class="calendar__day day">19</div>
        <div class="calendar__day day">20</div>
        <div class="calendar__day day">21</div>    
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">22</div>
        <div class="calendar__day day">23</div>
        <div class="calendar__day day">24</div>
        <div class="calendar__day day">25</div>
        <div class="calendar__day day">26</div> 
        <div class="calendar__day day">27</div> 
        <div class="calendar__day day">28</div> 
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">29</div>
        <div class="calendar__day day">30</div>
        <div class="calendar__day day">31</div>
        <div class="calendar__day day">1</div>
        <div class="calendar__day day">2</div>
        <div class="calendar__day day">3</div>
        <div class="calendar__day day">4</div>
      </div>
    </div>
  </main>
  <sidebar>
    <div class="logo">logo</div>
    <div class="avatar">
      <div class="avatar__img">
        <img src="https://picsum.photos/70" alt="avatar">
      </div>
      <div class="avatar__name">John Smith</div>
    </div>
    <nav class="menu">
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-home"></i>
        <span class="menu__text">overview</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-envelope"></i>
        <span class="menu__text">messages</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-list"></i>
        <span class="menu__text">workout</span>
      </a>
      <a class="menu__item menu__item--active" href="#">
        <i class="menu__icon fa fa-calendar"></i>
        <span class="menu__text">calendar</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-bar-chart"></i>
        <span class="menu__text">goals</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-trophy"></i>
        <span class="menu__text">achivements</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-sliders"></i>
        <span class="menu__text">measurements</span>
      </a>
    </nav>
    <div class="copyright">copyright &copy; 2018</div>
  </sidebar>
</div>
	</body>
</html>