


// 날짜 형식 검사 
function isValidDateFormat(date) {
	let p = /^[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}$/;
	if(! p.test(date)) {
		return false;
	}
	
	date = date.replace(/(\.)|(\-)|(\/)/g, "");
	
	let y = parseInt(date.substring(0,4));
	let m = parseInt(date.substring(4,6));
	let d = parseInt(date.substring(6));
	
	if(m<1 || m>12) {
		return false;
	}
	
	let lastDay = (new Date(y,m,0)).getDate();
	if(d<1 || d>lastDay) {
		return false;
	}
	
	return true;
}

// 날짜를 문자열로 변환.......  
function dateToString(date) {
	let y = date.getFullYear();
	let m = date.getMonth() + 1;
	if(m<10) m = "0" + m;
	let d = date.getDate();
	if(d<10) d = "0" + d;
	
	
	return `${y}-${m}-${d}`;
} 



// 기준일부터 며칠 후 (기준일포함)
function daysLater(startDate, days) {
	if(! isValidDateFormat(startDate)){
		throw '날짜 형식이 올바르지 않습니다.';
	}
	
	let y, m, d;
	let date = new Date();
	
	startDate = startDate.replace(/(\.)|(\-)|(\/)/g, "");
	y = parseInt(startDate.substring(0,4));
	m = parseInt(startDate.substring(4,6));
	d = parseInt(startDate.substring(6)) + parseInt(days) - 1;
	
	date.setFullYear(y, m-1, d);
	
	return dateToString(date); 
	
}


// 두 날짜간의 간격 계산
function toDiffDays(startDate,endDate){
	if(! isValidDateFormat(startDate) ||! isValidDateFormat(endDate) ){
		throw '날짜 형식이 올바르지 않습니다.';
	}
	
	startDate = startDate.replace(/(\.)|(\-)|(\/)/g, "");
	endDate = endDate.replace(/(\.)|(\-)|(\/)/g, "");
	
	let sy = parseInt(startDate.substring(0,4));
	let sm = parseInt(startDate.substring(4,6));
	let sd = parseInt(startDate.substring(6));
	
	let ey = parseInt(endDate.substring(0,4));
	let em = parseInt(endDate.substring(4,6));
	let ed = parseInt(endDate.substring(6));
	
	let date1 = new Date(sy, sm-1, sd);
	let date2 = new Date(ey, em-1, ed);
	
	let dif = date2.getTime()-date1.getTime();
	
	let day = Math.floor(dif / (24 * 3600 * 1000));
	
	return day + 1; 
}


function toAge(birth) {
	if(! isValidDateFormat(birth)){
		throw '날짜 형식이 올바르지 않습니다.';
	}
	
	birth = birth.replace(/(\.)|(\-)|(\/)/g, "");
	let y = parseInt(birth.substring(0,4));
	let m = parseInt(birth.substring(4,6));
	let d = parseInt(birth.substring(6));
	
	let bd = new Date(y, m-1, d);
	let nd = new Date();
	
	let age = nd.getFullYear() - bd.getFullYear();
	if(bd.getMonth() > nd.getMonth() || 
			(bd.getMonth()===nd.getMonth() && bd.getDate()>nd.getDate()) ){
				age--;
			}
	
	return age;
}
